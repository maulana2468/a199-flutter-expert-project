part of 'popular_tvseries_bloc.dart';

class PopularTvSeriesState extends Equatable {
  PopularTvSeriesState({
    this.state = RequestState.Empty,
    List<TvSeries>? tvseries,
    this.message = "",
  }) : tvseries = tvseries ?? [];

  final RequestState state;
  final List<TvSeries> tvseries;
  final String message;

  PopularTvSeriesState copyWith({
    RequestState? state,
    List<TvSeries>? tvseries,
    String? message,
  }) {
    return PopularTvSeriesState(
      state: state ?? this.state,
      tvseries: tvseries ?? this.tvseries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        state,
        tvseries,
        message,
      ];
}
