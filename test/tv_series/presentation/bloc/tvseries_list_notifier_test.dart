import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_now_playing_tvseries.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/features/tv_series/presentation/bloc/tvseries_list/tvseries_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetNowPlayingTvSeries extends Mock implements GetNowPlayingTvSeries {}

class MockGetPopularTvSeries extends Mock implements GetPopularTvSeries {}

class MockGetTopRatedTvSeries extends Mock implements GetTopRatedTvSeries {}

void main() {
  late TvSeriesListBloc movieListBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    movieListBloc = TvSeriesListBloc(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
  });

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

  group('now playing movies', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'initialState should be Empty',
      build: () {
        return movieListBloc;
      },
      expect: () => <TvSeriesListState>[],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should get data from the usecase',
      build: () {
        when(() => mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          nowPlayingState: RequestState.Loading,
        ),
        TvSeriesListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          nowPlayingState: RequestState.Loading,
        ),
        TvSeriesListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should change movies when data is gotten successfully',
      build: () {
        when(() => mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          nowPlayingState: RequestState.Loading,
        ),
        TvSeriesListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          nowPlayingState: RequestState.Loading,
        ),
        TvSeriesListState(
          nowPlayingState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });

  group('popular movies', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          popularTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState(
          popularTvSeriesState: RequestState.Loaded,
          popularTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should change movies when data is gotten successfully',
      build: () {
        when(() => mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          popularTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState(
          popularTvSeriesState: RequestState.Loaded,
          popularTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          popularTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState(
          popularTvSeriesState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });

  group('top rated movies', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          topRatedTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState(
          topRatedTvSeriesState: RequestState.Loaded,
          topRatedTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should change movies when data is gotten successfully',
      build: () {
        when(() => mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          topRatedTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState(
          topRatedTvSeriesState: RequestState.Loaded,
          topRatedTvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => <TvSeriesListState>[
        TvSeriesListState(
          topRatedTvSeriesState: RequestState.Loading,
        ),
        TvSeriesListState(
          topRatedTvSeriesState: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
