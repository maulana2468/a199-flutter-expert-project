import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/tv_series/presentation/pages/home_tvseries_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

import 'features/movies/presentation/pages/about_page.dart';
import 'features/movies/presentation/pages/home_movie_page.dart';
import 'features/movies/presentation/pages/movie_detail_page.dart';
import 'features/movies/presentation/pages/popular_movies_page.dart';
import 'features/movies/presentation/pages/search_page.dart';
import 'features/movies/presentation/pages/top_rated_movies_page.dart';
import 'features/movies/presentation/pages/watchlist_movies_page.dart';
import 'features/movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'features/movies/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'features/movies/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'features/movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'features/movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'features/movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'features/tv_series/presentation/pages/popular_tvseries_page.dart';
import 'features/tv_series/presentation/pages/search_tvseries_page.dart';
import 'features/tv_series/presentation/pages/top_rated_tvseries_page.dart';
import 'features/tv_series/presentation/pages/tvseries_detail_page.dart';
import 'features/tv_series/presentation/pages/watchlist_tvseries_page.dart';
import 'features/tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'features/tv_series/presentation/bloc/top_rated_tvseries/top_rated_tvseries_bloc.dart';
import 'features/tv_series/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'features/tv_series/presentation/bloc/tvseries_list/tvseries_list_bloc.dart';
import 'features/tv_series/presentation/bloc/tvseries_search/tvseries_search_bloc.dart';
import 'features/tv_series/presentation/bloc/watchlist_tvseries/watchlist_tvseries_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvSeriesPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvSeriesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
