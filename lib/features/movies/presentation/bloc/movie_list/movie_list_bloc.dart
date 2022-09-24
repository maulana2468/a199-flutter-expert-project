import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';
import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState()) {
    on<OnFetchNowPlayingMovies>((event, emit) async {
      emit(state.copyWith(nowPlayingState: RequestState.Loading));

      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              nowPlayingState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (moviesData) {
          emit(
            state.copyWith(
              nowPlayingState: RequestState.Loaded,
              nowPlayingMovies: moviesData,
            ),
          );
        },
      );
    });

    on<OnFetchPopularMovies>((event, emit) async {
      emit(state.copyWith(popularMoviesState: RequestState.Loading));

      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              popularMoviesState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (moviesData) {
          emit(
            state.copyWith(
              popularMoviesState: RequestState.Loaded,
              popularMovies: moviesData,
            ),
          );
        },
      );
    });

    on<OnFetchTopRatedMovies>((event, emit) async {
      emit(state.copyWith(topRatedMoviesState: RequestState.Loading));

      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              topRatedMoviesState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (moviesData) {
          emit(
            state.copyWith(
              topRatedMoviesState: RequestState.Loaded,
              topRatedMovies: moviesData,
            ),
          );
        },
      );
    });
  }
}
