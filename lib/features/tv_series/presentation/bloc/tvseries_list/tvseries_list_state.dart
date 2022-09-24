part of 'tvseries_list_bloc.dart';

class TvSeriesListState extends Equatable {
  TvSeriesListState({
    List<TvSeries>? nowPlayingTvSeries,
    this.nowPlayingState = RequestState.Empty,
    List<TvSeries>? popularTvSeries,
    this.popularTvSeriesState = RequestState.Empty,
    List<TvSeries>? topRatedTvSeries,
    this.topRatedTvSeriesState = RequestState.Empty,
    this.message = "",
  })  : nowPlayingTvSeries = nowPlayingTvSeries ?? [],
        popularTvSeries = popularTvSeries ?? [],
        topRatedTvSeries = topRatedTvSeries ?? [];

  final List<TvSeries> nowPlayingTvSeries;
  final RequestState nowPlayingState;
  final List<TvSeries> popularTvSeries;
  final RequestState popularTvSeriesState;
  final List<TvSeries> topRatedTvSeries;
  final RequestState topRatedTvSeriesState;
  final String message;

  TvSeriesListState copyWith({
    List<TvSeries>? nowPlayingTvSeries,
    RequestState? nowPlayingState,
    List<TvSeries>? popularTvSeries,
    RequestState? popularTvSeriesState,
    List<TvSeries>? topRatedTvSeries,
    RequestState? topRatedTvSeriesState,
    String? message,
  }) {
    return TvSeriesListState(
      nowPlayingTvSeries: nowPlayingTvSeries ?? this.nowPlayingTvSeries,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularTvSeries: popularTvSeries ?? this.popularTvSeries,
      popularTvSeriesState: popularTvSeriesState ?? this.popularTvSeriesState,
      topRatedTvSeries: topRatedTvSeries ?? this.topRatedTvSeries,
      topRatedTvSeriesState:
          topRatedTvSeriesState ?? this.topRatedTvSeriesState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        nowPlayingTvSeries,
        nowPlayingState,
        popularTvSeries,
        popularTvSeriesState,
        topRatedTvSeries,
        topRatedTvSeriesState,
      ];
}
