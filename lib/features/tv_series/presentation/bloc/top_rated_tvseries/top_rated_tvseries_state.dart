part of 'top_rated_tvseries_bloc.dart';

class TopRatedTvSeriesState extends Equatable {
  TopRatedTvSeriesState({
    this.state = RequestState.Empty,
    List<TvSeries>? tvSeries,
    this.message = "",
  }) : tvSeries = tvSeries ?? [];

  final RequestState state;
  final List<TvSeries> tvSeries;
  final String message;

  TopRatedTvSeriesState copyWith({
    RequestState? state,
    List<TvSeries>? tvSeries,
    String? message,
  }) {
    return TopRatedTvSeriesState(
      state: state ?? this.state,
      tvSeries: tvSeries ?? this.tvSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        state,
        tvSeries,
        message,
      ];
}
