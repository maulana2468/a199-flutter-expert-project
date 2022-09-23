import 'package:ditonton/features/tv_series/data/models/tvseries_model.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: '2020 - 07 - 07',
    name: 'TEST',
    originCountry: ["ID"],
    originalLanguage: "ID",
    originalName: "TEST",
  );

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    firstAirDate: '2020 - 07 - 07',
    name: 'TEST',
    originCountry: ["ID"],
    originalLanguage: "ID",
    originalName: "TEST",
  );

  test('should be a subclass of Movie entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
