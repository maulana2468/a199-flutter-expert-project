import 'package:dartz/dartz.dart';
import 'package:ditonton/features/movies/domain/entities/genre.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/entities/movie_detail.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/features/movies/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movies/domain/usecases/save_watchlist.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

class MockGetMovieRecommendations extends Mock
    implements GetMovieRecommendations {}

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchlist extends Mock implements SaveWatchlist {}

class MockRemoveWatchlist extends Mock implements RemoveWatchlist {}

void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  final tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(() => mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(() => mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(id: tId)),
      verify: (bloc) {
        verify(() => mockGetMovieDetail.execute(tId));
        verify(() => mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should change state to Loading when usecase is called',
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(id: tId)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          movie: MovieDetail(
            adult: false,
            backdropPath: "backdropPath",
            genres: [Genre(id: 0, name: "name")],
            id: 0,
            originalTitle: "originalTitle",
            overview: "overview",
            posterPath: "posterPath",
            releaseDate: "releaseDate",
            runtime: 0,
            title: "title",
            voteAverage: 0,
            voteCount: 0,
          ),
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loaded,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should change movie when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(id: tId)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          movie: MovieDetail(
            adult: false,
            backdropPath: "backdropPath",
            genres: [Genre(id: 0, name: "name")],
            id: 0,
            originalTitle: "originalTitle",
            overview: "overview",
            posterPath: "posterPath",
            releaseDate: "releaseDate",
            runtime: 0,
            title: "title",
            voteAverage: 0,
            voteCount: 0,
          ),
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loaded,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should change recommendation movies when data is gotten successfully',
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(id: tId)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          movie: MovieDetail(
            adult: false,
            backdropPath: "backdropPath",
            genres: [Genre(id: 0, name: "name")],
            id: 0,
            originalTitle: "originalTitle",
            overview: "overview",
            posterPath: "posterPath",
            releaseDate: "releaseDate",
            runtime: 0,
            title: "title",
            voteAverage: 0,
            voteCount: 0,
          ),
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loaded,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );
  });

  group('Get Movie Recommendations', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get data from the usecase',
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(id: tId)),
      verify: (bloc) {
        verify(() => mockGetMovieRecommendations.execute(tId));
      },
      expect: () => <MovieDetailState>[
        MovieDetailState(
          movie: MovieDetail(
            adult: false,
            backdropPath: "backdropPath",
            genres: [Genre(id: 0, name: "name")],
            id: 0,
            originalTitle: "originalTitle",
            overview: "overview",
            posterPath: "posterPath",
            releaseDate: "releaseDate",
            runtime: 0,
            title: "title",
            voteAverage: 0,
            voteCount: 0,
          ),
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loaded,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should update recommendation state when data is gotten successfully",
      build: () {
        _arrangeUsecase();
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(id: tId)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          movie: MovieDetail(
            adult: false,
            backdropPath: "backdropPath",
            genres: [Genre(id: 0, name: "name")],
            id: 0,
            originalTitle: "originalTitle",
            overview: "overview",
            posterPath: "posterPath",
            releaseDate: "releaseDate",
            runtime: 0,
            title: "title",
            voteAverage: 0,
            voteCount: 0,
          ),
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loaded,
          movieRecommendations: tMovies,
          recommendationState: RequestState.Loaded,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "should update error message when request in successful",
      build: () {
        when(() => mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(() => mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(id: tId)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          movie: MovieDetail(
            adult: false,
            backdropPath: "backdropPath",
            genres: [Genre(id: 0, name: "name")],
            id: 0,
            originalTitle: "originalTitle",
            overview: "overview",
            posterPath: "posterPath",
            releaseDate: "releaseDate",
            runtime: 0,
            title: "title",
            voteAverage: 0,
            voteCount: 0,
          ),
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Empty,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Loading,
          message: "",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loading,
          movieRecommendations: [],
          recommendationState: RequestState.Error,
          message: "Failed",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
        MovieDetailState(
          movie: testMovieDetail,
          movieState: RequestState.Loaded,
          movieRecommendations: [],
          recommendationState: RequestState.Error,
          message: "Failed",
          watchlistMessage: "",
          isAddedToWatchlist: false,
        ),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get the watchlist status',
      build: () {
        when(() => mockGetWatchlistStatus.execute(1))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchlistStatus(id: 1)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(() => mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Success'));
        when(() => mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchList(movieDetail: testMovieDetail)),
      expect: () => <MovieDetailState>[
        MovieDetailState(watchlistMessage: "Success"),
        MovieDetailState(isAddedToWatchlist: true, watchlistMessage: "Success"),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(() => mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(() => mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(movieDetail: testMovieDetail)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          isAddedToWatchlist: false,
          watchlistMessage: "Removed",
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(() => mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(() => mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchList(movieDetail: testMovieDetail)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          watchlistMessage: "Added to Watchlist",
        ),
        MovieDetailState(
          isAddedToWatchlist: true,
          watchlistMessage: "Added to Watchlist",
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(() => mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(() => mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnAddWatchList(movieDetail: testMovieDetail)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          watchlistMessage: "Failed",
        ),
      ],
    );
  });

  group('on Error', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(() => mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieDetail(id: tId)),
      expect: () => <MovieDetailState>[
        MovieDetailState(
          movieState: RequestState.Loading,
        ),
        MovieDetailState(
          movieState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
