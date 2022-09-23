import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/tvseries_detail.dart';
import '../repositories/tvseries_repository.dart';

class SaveTvSeriesWatchlist {
  final TvSeriesRepository repository;

  SaveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail movie) {
    return repository.saveTvSeriesWatchlist(movie);
  }
}
