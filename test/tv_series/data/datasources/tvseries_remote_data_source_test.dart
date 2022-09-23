import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv_series/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/features/tv_series/data/models/tvseries_detail_model.dart';
import 'package:ditonton/features/tv_series/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late Map<String, String> head;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
    head = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    };
  });

  group('get Now Playing TvSeries', () {
    final tvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/airing_today.json')))
        .tvSeriesList;

    test('should return list of TvSeries Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/airing_today.json'), 200,
              headers: head));
      // act
      final result = await dataSource.getNowPlayingTvSeries();
      // assert
      expect(result, equals(tvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TvSeries', () {
    final tvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tvseries.json')))
        .tvSeriesList;

    test('should return list of tvseries when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/popular_tvseries.json'), 200,
              headers: head));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, tvSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TvSeries', () {
    final tvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tvseries.json')))
        .tvSeriesList;

    test('should return list of tvseries when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/top_rated_tvseries.json'), 200,
              headers: head));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, tvSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series detail', () {
    final tId = 1;
    final tvSeriesDetail = tvSeriesDetailResponseFromJson(
        readJson('dummy_data/tvseries_detail.json'));

    test('should return tv_series detail name when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries_detail.json'), 200,
              headers: head));
      // act
      final result = await dataSource.getTvSeriesDetail(tId);
      // assert
      expect(result, equals(tvSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tvSeriesList = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tvseries_recommendations.json')))
        .tvSeriesList;
    final tId = 1;

    test('should return list of TvSeries Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tvseries_recommendations.json'), 200,
              headers: head));
      // act
      final result = await dataSource.getTvSeriesRecommendations(tId);
      // assert
      expect(result, equals(tvSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tvseries', () {
    final tSearchResult = TvSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_got_tvshow.json')))
        .tvSeriesList;
    final tQuery = 'Game Of Thrones';

    test('should return list of tvseries when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_got_tvshow.json'), 200));
      // act
      final result = await dataSource.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
