import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/features/tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetTopRatedTvSeries extends Mock implements GetTopRatedTvSeries {}

void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc =
        TopRatedTvSeriesBloc(getTopRatedTvSeries: mockGetTopRatedTvSeries);
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

  group("top rated", () {
    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should change state to Loading when usecase is called',
      build: () {
        when(() => mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => <TopRatedTvSeriesState>[
        TopRatedTvSeriesState(
          state: RequestState.Loading,
        ),
        TopRatedTvSeriesState(
          state: RequestState.Loaded,
          tvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should change tvSeries data data is gotten successfully',
      build: () {
        when(() => mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => <TopRatedTvSeriesState>[
        TopRatedTvSeriesState(
          state: RequestState.Loading,
        ),
        TopRatedTvSeriesState(
          state: RequestState.Loaded,
          tvSeries: tTvSeriesList,
        ),
      ],
    );

    blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvSeries()),
      expect: () => <TopRatedTvSeriesState>[
        TopRatedTvSeriesState(
          state: RequestState.Loading,
        ),
        TopRatedTvSeriesState(
          state: RequestState.Error,
          message: "Server Failure",
        ),
      ],
    );
  });
}
