import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import '../entities/tvseries_detail.dart';
import '../repositories/tvseries_repository.dart';

class RemoveTvSeriesWatchlist {
  final TvSeriesRepository repository;

  RemoveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return repository.removeTvSeriesWatchlist(tv);
  }
}
