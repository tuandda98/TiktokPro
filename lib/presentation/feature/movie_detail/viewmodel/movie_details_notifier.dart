import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/common/result.dart';
import '../../../../domain/usecases/get_movie_detail_usecase.dart';
import 'movie_details_state.dart';

class MovieDetailsNotifier extends StateNotifier<MovieDetailsState> {
  final GetMovieDetailUseCase _getMovieDetailUseCase;

  MovieDetailsNotifier(this._getMovieDetailUseCase) : super(MovieDetailsState.initial());

  void updateCurrentMovieLabel(int currentIndex, List<Map<String, dynamic>> videoData) {
    if (state.movieDetail == null || currentIndex >= videoData.length) return;

    final currentVideo = videoData[currentIndex];
    final isTrailer = currentVideo['type'] == 'trailer';

    String movieLabel;
    if (isTrailer) {
      final name = currentVideo['title'] ?? 'this is tile';
      final progress = state.movieDetail!.progress;
      movieLabel = '$name • ${progress.toStringAsFixed(0)}%';
    } else {
      final movieNumber = currentVideo['movie_number'] ?? 1;
      final totalSubMovies = state.movieDetail!.subMovies.fold(0, (sum, subMovie) => sum + subMovie.movieSegments.length);
      movieLabel = '$movieNumber: Part $currentIndex/$totalSubMovies';
    }

    state = state.copyWith(currentMovieLabel: movieLabel);
  }

  Future<void> loadMovieDetail(String movieId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _getMovieDetailUseCase(movieId);

    switch (result) {
      case Success(data: final movieDetail):
        state = state.copyWith(movieDetail: movieDetail, isLoading: false);
      case Error(error: final failure):
        state = state.copyWith(error: failure, isLoading: false);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}