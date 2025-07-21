import '../../../../core/error/failure.dart';
import '../../../../domain/entities/movie_detail.dart';

class MovieDetailsState {
  final MovieDetail? movieDetail;
  final bool isLoading;
  final Failure? error;
  final String currentMovieLabel;

  MovieDetailsState({
    this.movieDetail,
    this.isLoading = false,
    this.error,
    this.currentMovieLabel = '',
  });

  factory MovieDetailsState.initial() => MovieDetailsState();

  MovieDetailsState copyWith({
    MovieDetail? movieDetail,
    bool? isLoading,
    Failure? error,
    String? currentMovieLabel,
  }) {
    return MovieDetailsState(
      movieDetail: movieDetail ?? this.movieDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentMovieLabel: currentMovieLabel ?? this.currentMovieLabel,
    );
  }
}