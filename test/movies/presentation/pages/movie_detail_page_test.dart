import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/features/movies/presentation/pages/movie_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

void main() {
  late MockMovieDetailBloc mockNotifier;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
  });
  setUp(() {
    mockNotifier = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      MovieDetailState(
        movieState: RequestState.Loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      MovieDetailState(
        movieState: RequestState.Loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      MovieDetailState(
        movieState: RequestState.Loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: false,
        watchlistMessage: 'Added to Watchlist',
      ),
    );
    // when(() => mockNotifier.state.movieState).thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.state.movie).thenReturn(testMovieDetail);
    // when(() => mockNotifier.state.recommendationState)
    //     .thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.state.movieRecommendations).thenReturn(<Movie>[]);
    // when(() => mockNotifier.state.isAddedToWatchlist).thenReturn(false);
    // when(() => mockNotifier.state.watchlistMessage)
    //     .thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump(Duration(milliseconds: 100));

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      MovieDetailState(
        movieState: RequestState.Loaded,
        movie: testMovieDetail,
        recommendationState: RequestState.Loaded,
        movieRecommendations: <Movie>[],
        isAddedToWatchlist: false,
        watchlistMessage: 'Failed',
      ),
    );
    // when(() => mockNotifier.state.movieState).thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.state.movie).thenReturn(testMovieDetail);
    // when(() => mockNotifier.state.recommendationState)
    //     .thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.state.movieRecommendations).thenReturn(<Movie>[]);
    // when(() => mockNotifier.state.isAddedToWatchlist).thenReturn(false);
    // when(() => mockNotifier.state.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump(Duration(milliseconds: 100));

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
