part of 'top_rated_movies_bloc.dart';

class TopRatedMoviesState extends Equatable {
  TopRatedMoviesState({
    this.state = RequestState.Empty,
    List<Movie>? movies,
    this.message = "",
  }) : movies = movies ?? [];

  final RequestState state;
  final List<Movie> movies;
  final String message;

  TopRatedMoviesState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return TopRatedMoviesState(
      state: state ?? this.state,
      movies: movies ?? this.movies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        state,
        movies,
        message,
      ];
}
