import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvSeriesWatchlist usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveTvSeriesWatchlist(mockTvSeriesRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeTvSeriesWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.removeTvSeriesWatchlist(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
