import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvseries.dart';
import '../../../domain/usecases/get_now_playing_tvseries.dart';
import '../../../domain/usecases/get_popular_tvseries.dart';
import '../../../domain/usecases/get_top_rated_tvseries.dart';

part 'tvseries_list_event.dart';
part 'tvseries_list_state.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListBloc({
    required this.getNowPlayingTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(TvSeriesListState()) {
    on<OnFetchNowPlayingTvSeries>((event, emit) async {
      emit(state.copyWith(nowPlayingState: RequestState.Loading));

      final result = await getNowPlayingTvSeries.execute();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              nowPlayingState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (tvSeriesData) {
          emit(
            state.copyWith(
              nowPlayingState: RequestState.Loaded,
              nowPlayingTvSeries: tvSeriesData,
            ),
          );
        },
      );
    });

    on<OnFetchPopularTvSeries>((event, emit) async {
      emit(state.copyWith(popularTvSeriesState: RequestState.Loading));

      final result = await getPopularTvSeries.execute();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              popularTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (tvSeriesData) {
          emit(
            state.copyWith(
              popularTvSeriesState: RequestState.Loaded,
              popularTvSeries: tvSeriesData,
            ),
          );
        },
      );
    });

    on<OnFetchTopRatedTvSeries>((event, emit) async {
      emit(state.copyWith(topRatedTvSeriesState: RequestState.Loading));

      final result = await getTopRatedTvSeries.execute();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              topRatedTvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (tvSeriesData) {
          emit(
            state.copyWith(
              topRatedTvSeriesState: RequestState.Loaded,
              topRatedTvSeries: tvSeriesData,
            ),
          );
        },
      );
    });
  }
}
