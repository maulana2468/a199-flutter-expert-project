import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:ditonton/features/tv_series/presentation/bloc/popular_tvseries/popular_tvseries_bloc.dart';
import 'package:ditonton/features/tv_series/presentation/pages/popular_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularTvSeriesBloc
    extends MockBloc<PopularTvSeriesEvent, PopularTvSeriesState>
    implements PopularTvSeriesBloc {}

class PopularTvSeriesEventFake extends Fake implements PopularTvSeriesEvent {}

class PopularTvSeriesStateFake extends Fake implements PopularTvSeriesState {}

void main() {
  late MockPopularTvSeriesBloc mockNotifier;

  setUpAll(() {
    registerFallbackValue(PopularTvSeriesEventFake());
    registerFallbackValue(PopularTvSeriesStateFake());
  });

  setUp(() {
    mockNotifier = MockPopularTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesBloc>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      PopularTvSeriesState(
        state: RequestState.Loading,
      ),
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      PopularTvSeriesState(
        state: RequestState.Loaded,
        tvseries: <TvSeries>[],
      ),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNotifier.state).thenReturn(
      PopularTvSeriesState(
        state: RequestState.Error,
        message: 'Error message',
      ),
    );

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
