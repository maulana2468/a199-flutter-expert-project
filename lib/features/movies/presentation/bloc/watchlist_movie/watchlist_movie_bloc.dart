import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies})
      : super(WatchlistMovieState()) {
    on<OnFetchWatchlistMovies>((event, emit) async {
      emit(state.copyWith(watchlistState: RequestState.Loading));

      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              watchlistState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (moviesData) {
          emit(
            state.copyWith(
              watchlistState: RequestState.Loaded,
              watchlistMovies: moviesData,
            ),
          );
        },
      );
    });
  }
}
