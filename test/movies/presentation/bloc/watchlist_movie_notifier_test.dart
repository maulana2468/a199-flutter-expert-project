import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  group("watchlist movie", () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should change movies data data is gotten successfully',
      build: () {
        when(() => mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovies()),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieState(
          watchlistState: RequestState.Loading,
        ),
        WatchlistMovieState(
          watchlistState: RequestState.Loaded,
          watchlistMovies: [testMovie],
        ),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovies()),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieState(
          watchlistState: RequestState.Loading,
        ),
        WatchlistMovieState(
          watchlistState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
