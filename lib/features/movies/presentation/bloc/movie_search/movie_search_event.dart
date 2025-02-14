part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieSearch extends MovieSearchEvent {
  OnFetchMovieSearch({required this.query});

  final String query;
}
