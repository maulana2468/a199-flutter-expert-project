part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  MovieDetailState({
    MovieDetail? movie,
    this.movieState = RequestState.Empty,
    List<Movie>? movieRecommendations,
    this.recommendationState = RequestState.Empty,
    this.message = "",
    this.isAddedToWatchlist = false,
    this.watchlistMessage = "",
  })  : movie = movie ??
            MovieDetail(
              adult: false,
              backdropPath: "backdropPath",
              genres: [Genre(id: 0, name: "name")],
              id: 0,
              originalTitle: "originalTitle",
              overview: "overview",
              posterPath: "posterPath",
              releaseDate: "releaseDate",
              runtime: 0,
              title: "title",
              voteAverage: 0,
              voteCount: 0,
            ),
        movieRecommendations = movieRecommendations ?? [];

  final MovieDetail movie;
  final RequestState movieState;
  final List<Movie> movieRecommendations;
  final RequestState recommendationState;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  MovieDetailState copyWith({
    MovieDetail? movie,
    RequestState? movieState,
    List<Movie>? movieRecommendations,
    RequestState? recommendationState,
    String? message,
    bool? isAddedtoWatchlist,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      movieState: movieState ?? this.movieState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedtoWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object> get props => [
        movie,
        movieState,
        movieRecommendations,
        recommendationState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
