import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/features/tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPopularTvSeries extends Mock implements GetPopularTvSeries {}

void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc =
        PopularTvSeriesBloc(getPopularTvSeries: mockGetPopularTvSeries);
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

  group("popular tvseries", () {
    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => <PopularTvSeriesState>[
        PopularTvSeriesState(
          state: RequestState.Loading,
        ),
        PopularTvSeriesState(
          state: RequestState.Loaded,
          tvseries: tTvSeriesList,
        ),
      ],
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should change tvseries data data is gotten successfully',
      build: () {
        when(() => mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => <PopularTvSeriesState>[
        PopularTvSeriesState(
          state: RequestState.Loading,
        ),
        PopularTvSeriesState(
          state: RequestState.Loaded,
          tvseries: tTvSeriesList,
        ),
      ],
    );

    blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvSeries()),
      expect: () => <PopularTvSeriesState>[
        PopularTvSeriesState(
          state: RequestState.Loading,
        ),
        PopularTvSeriesState(
          state: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
