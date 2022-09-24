import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies})
      : super(TopRatedMoviesState()) {
    on<OnFetchTopRatedMovies>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));

      final result = await getTopRatedMovies.execute();

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
