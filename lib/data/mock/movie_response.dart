import '../models/movie_model.dart';

class MovieResponse {
  final List<MovieModel> movies;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final bool hasNext;

  MovieResponse({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.hasNext,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      movies: (json['data'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList(),
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      hasNext: json['hasNext'],
    );
  }
}