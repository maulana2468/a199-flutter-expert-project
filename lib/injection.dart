import 'package:ditonton/common/ssl_certificate.dart';
import 'package:ditonton/features/movies/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/movies/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/features/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tvseries_status.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'features/movies/domain/usecases/get_movie_detail.dart';
import 'features/movies/domain/usecases/get_movie_recommendations.dart';
import 'features/movies/domain/usecases/get_now_playing_movies.dart';
import 'features/movies/domain/usecases/get_popular_movies.dart';
import 'features/movies/domain/usecases/get_top_rated_movies.dart';
import 'features/movies/domain/usecases/get_watchlist_movies.dart';
import 'features/movies/domain/usecases/get_watchlist_status.dart';
import 'features/movies/domain/usecases/remove_watchlist.dart';
import 'features/movies/domain/usecases/save_watchlist.dart';
import 'features/movies/domain/usecases/search_movies.dart';
import 'features/movies/presentation/provider/movie_detail_notifier.dart';
import 'features/movies/presentation/provider/movie_list_notifier.dart';
import 'features/movies/presentation/provider/movie_search_notifier.dart';
import 'features/movies/presentation/provider/popular_movies_notifier.dart';
import 'features/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'features/movies/presentation/provider/watchlist_movie_notifier.dart';
import 'features/tv_series/data/datasources/db/database_tvseries_helper.dart';
import 'features/tv_series/data/datasources/tvseries_local_data_source.dart';
import 'features/tv_series/data/datasources/tvseries_remote_data_source.dart';
import 'features/tv_series/data/repositories/tvseries_repository_impl.dart';
import 'features/tv_series/domain/repositories/tvseries_repository.dart';
import 'features/tv_series/domain/usecases/get_now_playing_tvseries.dart';
import 'features/tv_series/domain/usecases/get_popular_tvseries.dart';
import 'features/tv_series/domain/usecases/get_top_rated_tvseries.dart';
import 'features/tv_series/domain/usecases/get_tvseries_detail.dart';
import 'features/tv_series/domain/usecases/get_tvseries_recommendations.dart';
import 'features/tv_series/domain/usecases/remove_tvseries_watchlist.dart';
import 'features/tv_series/domain/usecases/save_tvseries_watchlist.dart';
import 'features/tv_series/domain/usecases/search_tvseries.dart';
import 'features/tv_series/presentation/provider/popular_tvseries_notifier.dart';
import 'features/tv_series/presentation/provider/top_rated_tvseries_notifier.dart';
import 'features/tv_series/presentation/provider/tvseries_detail_notifier.dart';
import 'features/tv_series/presentation/provider/tvseries_list_notifiler.dart';
import 'features/tv_series/presentation/provider/tvseries_search_notifier.dart';
import 'features/tv_series/presentation/provider/watchlist_tvseries_notifier.dart';

final locator = GetIt.instance;

void init() async {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesListNotifier(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchNotifier(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesNotifier(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesNotifier(
      getWatchlistTvSeries: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseTvSeriesHelper>(
      () => DatabaseTvSeriesHelper());

  // external
  final client = await getIoClient();
  locator.registerLazySingleton(() => client);
}
