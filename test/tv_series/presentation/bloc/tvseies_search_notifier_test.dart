import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/domain/usecases/search_movies.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:ditonton/features/tv_series/domain/usecases/search_tvseries.dart';
import 'package:ditonton/features/tv_series/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchTvSeries extends Mock implements SearchTvSeries {}

void main() {
  late TvSeriesSearchBloc movieSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    movieSearchBloc = TvSeriesSearchBloc(searchTvSeries: mockSearchTvSeries);
  });

  final tTvSeriesModel = TvSeries(
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
  final tTvSeriesList = <TvSeries>[tTvSeriesModel];
  final tQuery = 'spiderman';

  group('search movies', () {
    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesSearch(query: tQuery)),
      expect: () => <TvSeriesSearchState>[
        TvSeriesSearchState(
          state: RequestState.Loading,
        ),
        TvSeriesSearchState(
          state: RequestState.Loaded,
          searchResult: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'should change search when data is gotten successfully',
      build: () {
        when(() => mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvSeriesList));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesSearch(query: tQuery)),
      expect: () => <TvSeriesSearchState>[
        TvSeriesSearchState(
          state: RequestState.Loading,
        ),
        TvSeriesSearchState(
          state: RequestState.Loaded,
          searchResult: tTvSeriesList,
        ),
      ],
    );

    blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvSeriesSearch(query: tQuery)),
      expect: () => <TvSeriesSearchState>[
        TvSeriesSearchState(
          state: RequestState.Loading,
        ),
        TvSeriesSearchState(
          state: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
