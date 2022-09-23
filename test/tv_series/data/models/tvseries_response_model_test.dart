import 'dart:convert';
import 'package:ditonton/features/tv_series/data/models/tvseries_model.dart';
import 'package:ditonton/features/tv_series/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: "TEST",
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
  final tTvSeriesResponseModel =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/simple_airing_today.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": 'posterPath',
            "popularity": 1.0,
            "id": 1,
            "backdrop_path": "TEST",
            "vote_average": 1.0,
            "overview": 'overview',
            "first_air_date": '2020 - 07 - 07',
            "origin_country": ["ID"],
            "genre_ids": [1, 2, 3],
            "original_language": "ID",
            "vote_count": 1,
            "name": 'TEST',
            "original_name": "TEST",
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
