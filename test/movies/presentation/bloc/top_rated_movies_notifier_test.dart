import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc =
        TopRatedMoviesBloc(getTopRatedMovies: mockGetTopRatedMovies);
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

  group("top rated", () {
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovies()),
      expect: () => <TopRatedMoviesState>[
        TopRatedMoviesState(
          state: RequestState.Loading,
        ),
        TopRatedMoviesState(
          state: RequestState.Loaded,
          movies: tMovieList,
        ),
      ],
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'should change movies data data is gotten successfully',
      build: () {
        when(() => mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovies()),
      expect: () => <TopRatedMoviesState>[
        TopRatedMoviesState(
          state: RequestState.Loading,
        ),
        TopRatedMoviesState(
          state: RequestState.Loaded,
          movies: tMovieList,
        ),
      ],
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovies()),
      expect: () => <TopRatedMoviesState>[
        TopRatedMoviesState(
          state: RequestState.Loading,
        ),
        TopRatedMoviesState(
          state: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
