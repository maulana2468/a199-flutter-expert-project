import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../common/state_enum.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies})
      : super(PopularMoviesState()) {
    on<OnFetchPopularMovies>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              state: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (moviesData) {
          emit(
            state.copyWith(
              state: RequestState.Loaded,
              movies: moviesData,
            ),
          );
        },
      );
    });
  }
}
