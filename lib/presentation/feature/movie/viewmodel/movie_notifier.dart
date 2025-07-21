import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/common/result.dart';
import '../../../../domain/usecases/get_movie_usecase.dart';
import 'movie_state.dart';

class MovieNotifier extends StateNotifier<MovieState> {
  final GetListMovieUseCase getMovieUseCase;

  MovieNotifier(this.getMovieUseCase) : super(MovieState());

  Future<void> loadMovie({int page = 1, bool isLoadMore = false}) async {
    if (!isLoadMore) {
      state = state.copyWith(isLoading: true, error: null);
    }

    final result = await getMovieUseCase(page: page);

    switch (result) {
      case Success(data: final movies):
        final updatedMovies = isLoadMore
            ? [...state.movies, ...movies]
            : movies;

        state = state.copyWith(
          isLoading: false,
          movies: updatedMovies,
          currentPage: page,
          hasNext: movies.length == 10, // Assuming limit is 10
        );
      case Error(error: final failure):
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}