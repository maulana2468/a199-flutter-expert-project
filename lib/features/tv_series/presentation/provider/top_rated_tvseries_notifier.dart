import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tvseries.dart';

import '../../domain/usecases/get_top_rated_tvseries.dart';

class TopRatedTvSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesNotifier({required this.getTopRatedTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _movies = [];
  List<TvSeries> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
