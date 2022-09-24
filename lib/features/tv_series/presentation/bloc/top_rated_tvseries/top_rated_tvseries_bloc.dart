import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvseries.dart';
import '../../../domain/usecases/get_top_rated_tvseries.dart';

part 'top_rated_tvseries_event.dart';
part 'top_rated_tvseries_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc({required this.getTopRatedTvSeries})
      : super(TopRatedTvSeriesState()) {
    on<OnFetchTopRatedTvSeries>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));

      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              state: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (tvSeriesData) {
          emit(
            state.copyWith(
              state: RequestState.Loaded,
              tvSeries: tvSeriesData,
            ),
          );
        },
      );
    });
  }
}
