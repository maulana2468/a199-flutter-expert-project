import 'package:ditonton/common/ssl_certificate.dart';
import 'package:ditonton/features/movies/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/movies/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/features/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tvseries_status.dart';
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
import 'features/movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'features/movies/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'features/movies/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'features/movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'features/movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'features/movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
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
import 'features/tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'features/tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'features/tv_series/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'features/tv_series/presentation/bloc/tvseries_list/tvseries_list_bloc.dart';
import 'features/tv_series/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'features/tv_series/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // provider
  locator.registerFactory(
    () => MovieListBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesListBloc(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchBloc(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesBloc(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesBloc(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesBloc(
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
