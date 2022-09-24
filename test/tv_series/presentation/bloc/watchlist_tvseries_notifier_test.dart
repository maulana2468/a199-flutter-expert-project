import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/features/tv_series/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistTvSeries extends Mock implements GetWatchlistTvSeries {}

void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    );
  });

  group("watchlist movie", () {
    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should change movies data data is gotten successfully',
      build: () {
        when(() => mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right([testTvSeries]));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTvSeries()),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesState(
          watchlistState: RequestState.Loading,
        ),
        WatchlistTvSeriesState(
          watchlistState: RequestState.Loaded,
          watchlistTvSeries: [testTvSeries],
        ),
      ],
    );

    blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTvSeries()),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesState(
          watchlistState: RequestState.Loading,
        ),
        WatchlistTvSeriesState(
          watchlistState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
