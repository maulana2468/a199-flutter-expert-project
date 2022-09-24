part of 'tvseries_search_bloc.dart';

class TvSeriesSearchState extends Equatable {
  TvSeriesSearchState({
    this.state = RequestState.Empty,
    List<TvSeries>? searchResult,
    this.message = "",
  }) : searchResult = searchResult ?? [];

  final RequestState state;
  final List<TvSeries> searchResult;
  final String message;

  TvSeriesSearchState copyWith({
    RequestState? state,
    List<TvSeries>? searchResult,
    String? message,
  }) {
    return TvSeriesSearchState(
      state: state ?? this.state,
      searchResult: searchResult ?? this.searchResult,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        state,
        searchResult,
        message,
      ];
}

class TvSeriesSearchInitial extends TvSeriesSearchState {}
