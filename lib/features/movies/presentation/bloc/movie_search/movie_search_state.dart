part of 'movie_search_bloc.dart';

class MovieSearchState extends Equatable {
  MovieSearchState({
    this.state = RequestState.Empty,
    List<Movie>? searchResult,
    this.message = "",
  }) : searchResult = searchResult ?? [];

  final RequestState state;
  final List<Movie> searchResult;
  final String message;

  MovieSearchState copyWith({
    RequestState? state,
    List<Movie>? searchResult,
    String? message,
  }) {
    return MovieSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        state,
        searchResult,
        message,
      ];
}

class MovieSearchInitial extends MovieSearchState {}
