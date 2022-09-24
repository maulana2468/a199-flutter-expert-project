import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

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
  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'initialState should be Empty',
      build: () {
        return movieListBloc;
      },
      expect: () => <MovieListState>[],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should get data from the usecase',
      build: () {
        when(() => mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should change movies when data is gotten successfully',
      build: () {
        when(() => mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState(
          nowPlayingState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });

  group('popular movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          popularMoviesState: RequestState.Loading,
        ),
        MovieListState(
          popularMoviesState: RequestState.Loaded,
          popularMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should change movies when data is gotten successfully',
      build: () {
        when(() => mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          popularMoviesState: RequestState.Loading,
        ),
        MovieListState(
          popularMoviesState: RequestState.Loaded,
          popularMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          popularMoviesState: RequestState.Loading,
        ),
        MovieListState(
          popularMoviesState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });

  group('top rated movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          topRatedMoviesState: RequestState.Loading,
        ),
        MovieListState(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should change movies when data is gotten successfully',
      build: () {
        when(() => mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          topRatedMoviesState: RequestState.Loading,
        ),
        MovieListState(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovies()),
      expect: () => <MovieListState>[
        MovieListState(
          topRatedMoviesState: RequestState.Loading,
        ),
        MovieListState(
          topRatedMoviesState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
