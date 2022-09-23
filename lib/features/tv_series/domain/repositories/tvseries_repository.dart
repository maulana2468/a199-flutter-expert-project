import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/tvseries.dart';
import '../entities/tvseries_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveTvSeriesWatchlist(TvSeriesDetail movie);
  Future<Either<Failure, String>> removeTvSeriesWatchlist(TvSeriesDetail movie);
  Future<bool> isTvAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}
