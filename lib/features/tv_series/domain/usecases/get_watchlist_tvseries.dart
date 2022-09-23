import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/tvseries.dart';
import '../repositories/tvseries_repository.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepository _repository;

  GetWatchlistTvSeries(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
