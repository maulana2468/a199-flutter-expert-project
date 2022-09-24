part of 'watchlist_tvseries_bloc.dart';

abstract class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnFetchWatchlistTvSeries extends WatchlistTvSeriesEvent {}
