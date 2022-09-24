part of 'watchlist_tvseries_bloc.dart';

class WatchlistTvSeriesState extends Equatable {
  WatchlistTvSeriesState({
    this.watchlistState = RequestState.Empty,
    List<TvSeries>? watchlistTvSeries,
    this.message = "",
  }) : watchlistTvSeries = watchlistTvSeries ?? [];

  final RequestState watchlistState;
  final List<TvSeries> watchlistTvSeries;
  final String message;

  WatchlistTvSeriesState copyWith({
    RequestState? watchlistState,
    List<TvSeries>? watchlistTvSeries,
    String? message,
  }) {
    return WatchlistTvSeriesState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistTvSeries: watchlistTvSeries ?? this.watchlistTvSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        watchlistState,
        watchlistTvSeries,
        message,
      ];
}
