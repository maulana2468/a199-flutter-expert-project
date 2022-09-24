import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/entities/genre.dart';
import 'package:ditonton/features/movies/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState()) {
    on<OnFetchMovieDetail>((event, emit) async {
      emit(state.copyWith(movieState: RequestState.Loading));

      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(
            state.copyWith(
              movieState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (movie) {
          emit(
            state.copyWith(
              recommendationState: RequestState.Loading,
              movie: movie,
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
            (movies) {
              emit(
                state.copyWith(
                  recommendationState: RequestState.Loaded,
                  movieRecommendations: movies,
                ),
              );
            },
          );
          emit(
            state.copyWith(
              movieState: RequestState.Loaded,
            ),
          );
        },
      );
    });

    on<OnAddWatchList>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);

      await result.fold(
        (failure) async {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) async {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(id: event.movieDetail.id));
    });

    on<OnRemoveWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);

      await result.fold(
        (failure) async {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) async {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(OnLoadWatchlistStatus(id: event.movieDetail.id));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedtoWatchlist: result));
    });
  }
}
