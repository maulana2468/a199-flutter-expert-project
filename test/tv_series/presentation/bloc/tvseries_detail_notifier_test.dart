import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tvseries_status.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/features/tv_series/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesDetail extends Mock implements GetTvSeriesDetail {}

class MockGetTvSeriesRecommendations extends Mock
    implements GetTvSeriesRecommendations {}

class MockGetWatchListStatus extends Mock
    implements GetTvSeriesWatchListStatus {}

class MockSaveWatchlist extends Mock implements SaveTvSeriesWatchlist {}

class MockRemoveWatchlist extends Mock implements RemoveTvSeriesWatchlist {}

void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    tvSeriesDetailBloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetTvSeriesDetail,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  final tId = 1;

  final tTvSeries = TvSeries(
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

  final tTvSeriesList = <TvSeries>[tTvSeries];

  void _arrangeUsecase() {
    when(() => mockGetTvSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(() => mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
  }

  group('Get TvSeries Detail', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesDetail(id: tId)),
      verify: (bloc) {
        verify(() => mockGetTvSeriesDetail.execute(tId));
        verify(() => mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should change state to Loading when usecase is called',
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesDetail(id: tId)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          tvSeries: TvSeriesDetail(
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
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loaded,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should change movie when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesDetail(id: tId)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          tvSeries: TvSeriesDetail(
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
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loaded,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should change recommendation movies when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesDetail(id: tId)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          tvSeries: TvSeriesDetail(
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
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loaded,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );
  });

  group('Get TvSeries Recommendations', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesDetail(id: tId)),
      verify: (bloc) {
        verify(() => mockGetTvSeriesRecommendations.execute(tId));
      },
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          tvSeries: TvSeriesDetail(
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
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loaded,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should update recommendation state when data is gotten successfully",
      build: () {
        _arrangeUsecase();
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesDetail(id: tId)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          tvSeries: TvSeriesDetail(
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
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loaded,
          tvSeriesRecommendations: tTvSeriesList,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      "should update error message when request in successful",
      build: () {
        when(() => mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        when(() => mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesDetail(id: tId)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          tvSeries: TvSeriesDetail(
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
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loading,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Error,
          message: "Failed",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          tvSeriesState: RequestState.Loaded,
          tvSeriesRecommendations: [],
          recommendationState: RequestState.Error,
          message: "Failed",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should get the watchlist status',
      build: () {
        when(() => mockGetWatchlistStatus.execute(1))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchlistStatus(id: 1)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(() => mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Success'));
        when(() => mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(OnAddWatchList(tvSeriesDetail: testTvSeriesDetail)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(watchlistMessage: "Success"),
        TvSeriesDetailState(
            isAddedToWatchlist: true, watchlistMessage: "Success"),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(() => mockRemoveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(() => mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(OnRemoveWatchlist(tvSeriesDetail: testTvSeriesDetail)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          isAddedToWatchlist: false,
          watchlistMessage: "Removed",
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(() => mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(() => mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(OnAddWatchList(tvSeriesDetail: testTvSeriesDetail)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          watchlistMessage: "Added to Watchlist",
        ),
        TvSeriesDetailState(
          isAddedToWatchlist: true,
          watchlistMessage: "Added to Watchlist",
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(() => mockSaveWatchlist.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return tvSeriesDetailBloc;
      },
      act: (bloc) =>
          bloc.add(OnAddWatchList(tvSeriesDetail: testTvSeriesDetail)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          watchlistMessage: "Failed",
        ),
      ],
    );
  });

  group('on Error', () {
    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(() => mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return tvSeriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesDetail(id: tId)),
      expect: () => <TvSeriesDetailState>[
        TvSeriesDetailState(
          tvSeriesState: RequestState.Loading,
        ),
        TvSeriesDetailState(
          tvSeriesState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
