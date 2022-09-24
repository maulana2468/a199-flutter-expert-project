import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
            .add(OnFetchWatchlistMovies()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
        .add(OnFetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.watchlistState == RequestState.Loaded) {
              if (state.watchlistMovies.isEmpty) {
                return Center(child: Text("Empty Data"));
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.watchlistMovies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.watchlistMovies.length,
                );
              }
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
