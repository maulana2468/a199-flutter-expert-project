import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tvseries.dart';
import '../../../domain/entities/tvseries_detail.dart';
import '../../../domain/usecases/get_tvseries_detail.dart';
import '../../../domain/usecases/get_tvseries_recommendations.dart';
import '../../../domain/usecases/get_watchlist_tvseries_status.dart';
import '../../../domain/usecases/remove_tvseries_watchlist.dart';
import '../../../domain/usecases/save_tvseries_watchlist.dart';

part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetTvSeriesWatchListStatus getWatchListStatus;
  final SaveTvSeriesWatchlist saveWatchlist;
  final RemoveTvSeriesWatchlist removeWatchlist;

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvSeriesDetailState()) {
    on<OnFetchTvSeriesDetail>((event, emit) async {
      emit(state.copyWith(tvSeriesState: RequestState.Loading));

      final detailResult = await getTvSeriesDetail.execute(event.id);
      final recommendationResult =
          await getTvSeriesRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(
            state.copyWith(
              tvSeriesState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (tvSeries) {
          emit(
            state.copyWith(
              recommendationState: RequestState.Loading,
              tvSeries: tvSeries,
            ),
          );

          recommendationResult.fold(
            (failure) {
              emit(
                state.copyWith(
                  recommendationState: RequestState.Error,
                  message: failure.message,
                ),
              );
            },
            (tvSeriess) {
              emit(
                state.copyWith(
                  recommendationState: RequestState.Loaded,
                  tvSeriesRecommendations: tvSeriess,
                ),
              );
            },
          );
          emit(
            state.copyWith(
              tvSeriesState: RequestState.Loaded,
            ),
          );
        },
      );
    });

    on<OnAddWatchList>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvSeriesDetail);

      await result.fold(
        (failure) async {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) async {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(id: event.tvSeriesDetail.id));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvSeriesDetail);

      await result.fold(
        (failure) async {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) async {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(id: event.tvSeriesDetail.id));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedtoWatchlist: result));
    });
  }
}
