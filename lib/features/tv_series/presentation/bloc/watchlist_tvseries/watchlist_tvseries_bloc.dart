import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvseries.dart';
import '../../../domain/usecases/get_watchlist_tvseries.dart';

part 'watchlist_tvseries_event.dart';
part 'watchlist_tveries_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesBloc({required this.getWatchlistTvSeries})
      : super(WatchlistTvSeriesState()) {
    on<OnFetchWatchlistTvSeries>((event, emit) async {
      emit(state.copyWith(watchlistState: RequestState.Loading));

      final result = await getWatchlistTvSeries.execute();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              watchlistState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (tvSeriesData) {
          emit(
            state.copyWith(
              watchlistState: RequestState.Loaded,
              watchlistTvSeries: tvSeriesData,
            ),
          );
        },
      );
    });
  }
}
