import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:ditonton/features/tv_series/presentation/bloc/tvseries_detail/tvseries_detail_bloc.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tvseries_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/dummy_objects.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class TvSeriesDetailEventFake extends Fake implements TvSeriesDetailEvent {}

class TvSeriesDetailStateFake extends Fake implements TvSeriesDetailState {}

void main() {
  late MockTvSeriesDetailBloc mockNotifier;

  setUpAll(() {
    registerFallbackValue(TvSeriesDetailEventFake());
    registerFallbackValue(TvSeriesDetailStateFake());
  });
  setUp(() {
    mockNotifier = MockTvSeriesDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesDetailBloc>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tvSeries not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      TvSeriesDetailState(
        tvSeriesState: RequestState.Loaded,
        tvSeries: testTvSeriesDetail,
        recommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        isAddedToWatchlist: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tvSeries is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      TvSeriesDetailState(
        tvSeriesState: RequestState.Loaded,
        tvSeries: testTvSeriesDetail,
        recommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      TvSeriesDetailState(
        tvSeriesState: RequestState.Loaded,
        tvSeries: testTvSeriesDetail,
        recommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        isAddedToWatchlist: false,
        watchlistMessage: 'Added to Watchlist',
      ),
    );
    // when(() => mockNotifier.state.tvSeriesState).thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.state.tvSeries).thenReturn(testTvSeriesDetail);
    // when(() => mockNotifier.state.recommendationState)
    //     .thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.state.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
    // when(() => mockNotifier.state.isAddedToWatchlist).thenReturn(false);
    // when(() => mockNotifier.state.watchlistMessage)
    //     .thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

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
      TvSeriesDetailState(
        tvSeriesState: RequestState.Loaded,
        tvSeries: testTvSeriesDetail,
        recommendationState: RequestState.Loaded,
        tvSeriesRecommendations: <TvSeries>[],
        isAddedToWatchlist: false,
        watchlistMessage: 'Failed',
      ),
    );
    // when(() => mockNotifier.state.tvSeriesState).thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.state.tvSeries).thenReturn(testTvSeriesDetail);
    // when(() => mockNotifier.state.recommendationState)
    //     .thenReturn(RequestState.Loaded);
    // when(() => mockNotifier.state.tvSeriesRecommendations).thenReturn(<TvSeries>[]);
    // when(() => mockNotifier.state.isAddedToWatchlist).thenReturn(false);
    // when(() => mockNotifier.state.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump(Duration(milliseconds: 100));

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
