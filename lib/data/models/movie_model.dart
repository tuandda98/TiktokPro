import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.categoryCode,
    required super.name,
    required super.description,
    required super.totalLiked,
    required super.totalBookmarked,
    required super.isLiked,
    required super.isBookmarked,
    required super.isEnrolled,
    required super.progress,
    required super.thumbnail,
    required super.trailerVideoUrl,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      categoryCode: json['category_code'],
      name: json['name'],
      description: json['description'],
      totalLiked: json['total_liked'],
      totalBookmarked: json['total_bookmarked'],
      isLiked: json['is_liked'],
      isBookmarked: json['is_bookmarked'],
      isEnrolled: json['is_enrolled'],
      progress: json['progress'], // Keeping as is
      thumbnail: json['thumbnail'],
      trailerVideoUrl: json['trailer_video_url'],
    );
  }

  static List<MovieModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

  Movie toEntity() {
    return this;
  }
}