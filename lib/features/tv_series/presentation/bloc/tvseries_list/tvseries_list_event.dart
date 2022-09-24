part of 'tvseries_list_bloc.dart';

abstract class TvSeriesListEvent extends Equatable {
  const TvSeriesListEvent();

  @override
  List<Object> get props => [];
}

class OnFetchNowPlayingTvSeries extends TvSeriesListEvent {}

class OnFetchPopularTvSeries extends TvSeriesListEvent {}

class OnFetchTopRatedTvSeries extends TvSeriesListEvent {}
