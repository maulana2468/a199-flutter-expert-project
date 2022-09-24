import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc popularMoviesBloc;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc =
        PopularMoviesBloc(getPopularMovies: mockGetPopularMovies);
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

  group("popular movies", () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovies()),
      expect: () => <PopularMoviesState>[
        PopularMoviesState(
          state: RequestState.Loading,
        ),
        PopularMoviesState(
          state: RequestState.Loaded,
          movies: tMovieList,
        ),
      ],
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should change movies data data is gotten successfully',
      build: () {
        when(() => mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovies()),
      expect: () => <PopularMoviesState>[
        PopularMoviesState(
          state: RequestState.Loading,
        ),
        PopularMoviesState(
          state: RequestState.Loaded,
          movies: tMovieList,
        ),
      ],
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovies()),
      expect: () => <PopularMoviesState>[
        PopularMoviesState(
          state: RequestState.Loading,
        ),
        PopularMoviesState(
          state: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
