import 'package:ditonton/features/movies/data/models/movie_table.dart';
import 'package:ditonton/features/movies/domain/entities/genre.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/entities/movie_detail.dart';
import 'package:ditonton/features/tv_series/data/models/tvseries_table.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTvSeries = TvSeries(
  backdropPath: 'backdropPath',
  id: 1,
  originalLanguage: 'en',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  firstAirDate: "0 - 0 - 0",
  name: 'CCC',
  originCountry: ["ID"],
  originalName: 'CCC',
  genreIds: [1],
);

final testMovieList = [testMovie];
final testTvSeriesList = [testTvSeries];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeriesDetail = TvSeriesDetail(
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
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  posterPath: 'posterPath',
  overview: 'overview',
  name: 'name',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'posterPath': 'posterPath',
  'overview': 'overview',
};
