import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';

import '../repositories/tvseries_repository.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
