part of 'popular_movies_bloc.dart';

class PopularMoviesState extends Equatable {
  PopularMoviesState({
    this.state = RequestState.Empty,
    List<Movie>? movies,
    this.message = "",
  }) : movies = movies ?? [];

  final RequestState state;
  final List<Movie> movies;
  final String message;

  PopularMoviesState copyWith({
    RequestState? state,
    List<Movie>? movies,
    String? message,
  }) {
    return PopularMoviesState(
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
