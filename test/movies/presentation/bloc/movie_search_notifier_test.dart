import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/search_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
  });

  final tMovieModel = Movie(
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
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  group('search movies', () {
    blocTest<MovieSearchBloc, MovieSearchState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieSearch(query: tQuery)),
      expect: () => <MovieSearchState>[
        MovieSearchState(
          state: RequestState.Loading,
        ),
        MovieSearchState(
          state: RequestState.Loaded,
          searchResult: tMovieList,
        ),
      ],
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should change search when data is gotten successfully',
      build: () {
        when(() => mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieSearch(query: tQuery)),
      expect: () => <MovieSearchState>[
        MovieSearchState(
          state: RequestState.Loading,
        ),
        MovieSearchState(
          state: RequestState.Loaded,
          searchResult: tMovieList,
        ),
      ],
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieSearch(query: tQuery)),
      expect: () => <MovieSearchState>[
        MovieSearchState(
          state: RequestState.Loading,
        ),
        MovieSearchState(
          state: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
