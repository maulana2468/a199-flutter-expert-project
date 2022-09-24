part of 'tvseries_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvSeriesDetail extends TvSeriesDetailEvent {
  OnFetchTvSeriesDetail({required this.id});

  final int id;
}

class OnAddWatchList extends TvSeriesDetailEvent {
  OnAddWatchList({required this.tvSeriesDetail});

  final TvSeriesDetail tvSeriesDetail;
}

class OnRemoveWatchlist extends TvSeriesDetailEvent {
  OnRemoveWatchlist({required this.tvSeriesDetail});

  final TvSeriesDetail tvSeriesDetail;
}

class OnLoadWatchlistStatus extends TvSeriesDetailEvent {
  OnLoadWatchlistStatus({required this.id});

  final int id;
}
