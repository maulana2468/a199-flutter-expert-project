import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common/state_enum.dart';
import '../../../domain/entities/tvseries.dart';
import '../../../domain/usecases/get_popular_tvseries.dart';

part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc({required this.getPopularTvSeries})
      : super(PopularTvSeriesState()) {
    on<OnFetchPopularTvSeries>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));

      final result = await getPopularTvSeries.execute();

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              state: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (tvseriesData) {
          emit(
            state.copyWith(
              state: RequestState.Loaded,
              tvseries: tvseriesData,
            ),
          );
        },
      );
    });
  }
}
