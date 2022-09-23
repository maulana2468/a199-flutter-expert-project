import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/tvseries.dart';
import '../repositories/tvseries_repository.dart';

class GetNowPlayingTvSeries {
  final TvSeriesRepository repository;

  GetNowPlayingTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlayingTvSeries();
  }
}
