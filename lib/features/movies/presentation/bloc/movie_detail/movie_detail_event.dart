part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  OnFetchMovieDetail({required this.id});

  final int id;
}

class OnAddWatchList extends MovieDetailEvent {
  OnAddWatchList({required this.movieDetail});

  final MovieDetail movieDetail;
}

class OnRemoveWatchlist extends MovieDetailEvent {
  OnRemoveWatchlist({required this.movieDetail});

  final MovieDetail movieDetail;
}

class OnLoadWatchlistStatus extends MovieDetailEvent {
  OnLoadWatchlistStatus({required this.id});

  final int id;
}
