part of 'tvseries_search_bloc.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTvSeriesSearch extends TvSeriesSearchEvent {
  OnFetchTvSeriesSearch({required this.query});

  final String query;
}
