part of 'watchlist_movie_bloc.dart';

class WatchlistMovieState extends Equatable {
  WatchlistMovieState({
    this.watchlistState = RequestState.Empty,
    List<Movie>? watchlistMovies,
    this.message = "",
  }) : watchlistMovies = watchlistMovies ?? [];

  final RequestState watchlistState;
  final List<Movie> watchlistMovies;
  final String message;

  WatchlistMovieState copyWith({
    RequestState? watchlistState,
    List<Movie>? watchlistMovies,
    String? message,
  }) {
    return WatchlistMovieState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        watchlistState,
        watchlistMovies,
        message,
      ];
}
