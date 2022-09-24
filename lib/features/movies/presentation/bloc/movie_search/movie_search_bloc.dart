import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchInitial()) {
    on<OnFetchMovieSearch>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));

      final result = await searchMovies.execute(event.query);
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              state: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (data) {
          emit(
            state.copyWith(
              state: RequestState.Loaded,
              searchResult: data,
            ),
          );
        },
      );
    });
  }
}
