import '../../../../domain/entities/movie.dart';

class MovieState {
  final bool isLoading;
  final List<Movie> movies;
  final String? error;
  final int currentPage;
  final bool hasNext;

  MovieState({
    this.isLoading = false,
    this.movies = const [],
    this.error,
    this.currentPage = 1,
    this.hasNext = true,
  });

  MovieState copyWith({
    bool? isLoading,
    List<Movie>? movies,
    String? error,
    int? currentPage,
    bool? hasNext,
  }) {
    return MovieState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasNext: hasNext ?? this.hasNext,
    );
  }
}