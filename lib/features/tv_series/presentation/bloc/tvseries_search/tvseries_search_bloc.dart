import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/tvseries.dart';
import '../../../domain/usecases/search_tvseries.dart';

part 'tvseries_search_event.dart';
part 'tvseries_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchBloc({required this.searchTvSeries})
      : super(TvSeriesSearchInitial()) {
    on<OnFetchTvSeriesSearch>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));

      final result = await searchTvSeries.execute(event.query);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              state: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (data) {
          emit(
            state.copyWith(
              state: RequestState.Loaded,
              searchResult: data,
            ),
          );
        },
      );
    });
  }
}
