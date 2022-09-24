part of 'tvseries_detail_bloc.dart';

class TvSeriesDetailState extends Equatable {
  TvSeriesDetailState({
    TvSeriesDetail? tvSeries,
    this.tvSeriesState = RequestState.Empty,
    List<TvSeries>? tvSeriesRecommendations,
    this.recommendationState = RequestState.Empty,
    this.message = "",
    this.isAddedToWatchlist = false,
    this.watchlistMessage = "",
  })  : tvSeries = tvSeries ??
            TvSeriesDetail(
              backdropPath: 'backdropPath',
              genres: [GenreTvSeries(id: 1, name: "name")],
              id: 1,
              originalLanguage: 'en',
              overview: 'overview',
              popularity: 1,
              posterPath: 'posterPath',
              status: 'Status',
              tagline: 'Tagline',
              voteAverage: 1,
              voteCount: 1,
              createdBy: [
                CreatedBy(
                  id: 1,
                  creditId: "creditId",
                  name: "name",
                  gender: 0,
                  profilePath: "profilePath",
                ),
              ],
              episodeRunTime: [4],
              firstAirDate: DateTime(0, 0, 0),
              homepage: 'HOME',
              inProduction: true,
              languages: ["EN"],
              lastAirDate: DateTime(0, 0, 0),
              lastEpisodeToAir: LastEpisodeToAir(
                airDate: DateTime(0, 0, 0),
                episodeNumber: 3,
                id: 1,
                name: 'AAA',
                overview: 'BBB',
                productionCode: 'BBB',
                seasonNumber: 1,
                stillPath: '',
                voteAverage: 1,
                voteCount: 1,
              ),
              name: 'CCC',
              networks: [
                Network(
                  name: "name",
                  id: 1,
                  logoPath: "logoPath",
                  originCountry: "originCountry",
                ),
              ],
              nextEpisodeToAir: "",
              numberOfEpisodes: 9,
              numberOfSeasons: 3,
              originCountry: ["ID"],
              originalName: 'CCC',
              productionCompanies: [
                Network(
                  name: "name",
                  id: 2,
                  logoPath: "logoPath",
                  originCountry: "originCountry",
                ),
              ],
              productionCountries: [
                ProductionCountry(iso31661: "iso31661", name: "name"),
              ],
              seasons: [
                Season(
                  airDate: DateTime(0, 0, 0),
                  episodeCount: 7,
                  id: 3,
                  name: "name",
                  overview: "overview",
                  posterPath: "posterPath",
                  seasonNumber: 3,
                ),
              ],
              spokenLanguages: [
                SpokenLanguage(
                  englishName: "q",
                  iso6391: "iso6391",
                  name: "name",
                ),
              ],
              type: 'HI',
            ),
        tvSeriesRecommendations = tvSeriesRecommendations ?? [];

  final TvSeriesDetail tvSeries;
  final RequestState tvSeriesState;
  final List<TvSeries> tvSeriesRecommendations;
  final RequestState recommendationState;
  final String message;
  final bool isAddedToWatchlist;
  final String watchlistMessage;

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeries,
    RequestState? tvSeriesState,
    List<TvSeries>? tvSeriesRecommendations,
    RequestState? recommendationState,
    String? message,
    bool? isAddedtoWatchlist,
    String? watchlistMessage,
  }) {
    return TvSeriesDetailState(
      tvSeries: tvSeries ?? this.tvSeries,
      tvSeriesState: tvSeriesState ?? this.tvSeriesState,
      tvSeriesRecommendations:
          tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedtoWatchlist ?? this.isAddedToWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object> get props => [
        tvSeries,
        tvSeriesState,
        tvSeriesRecommendations,
        recommendationState,
        message,
        isAddedToWatchlist,
        watchlistMessage,
      ];
}
