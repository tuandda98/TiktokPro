import '../../domain/entities/movie_detail.dart';

class MovieDetailModel {
  final String id;
  final String categoryCode;
  final String name;
  final String description;
  final int totalLiked;
  final int totalBookmarked;
  final bool isLiked;
  final bool isBookmarked;
  final bool isEnrolled;
  final double progress;
  final String thumbnail;
  final String trailerVideoUrl;
  final List<SubMovieModel> subMovies;

  MovieDetailModel({
    required this.id,
    required this.categoryCode,
    required this.name,
    required this.description,
    required this.totalLiked,
    required this.totalBookmarked,
    required this.isLiked,
    required this.isBookmarked,
    required this.isEnrolled,
    required this.progress,
    required this.thumbnail,
    required this.trailerVideoUrl,
    required this.subMovies,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      categoryCode: json['category_code'],
      name: json['name'],
      description: json['description'],
      totalLiked: json['total_liked'],
      totalBookmarked: json['total_bookmarked'],
      isLiked: json['is_liked'],
      isBookmarked: json['is_bookmarked'],
      isEnrolled: json['is_enrolled'],
      progress: json['progress'].toDouble(),
      thumbnail: json['thumbnail'],
      trailerVideoUrl: json['trailer_video_url'],
      subMovies: (json['sub_movie'] as List)
          .map((subMovie) => SubMovieModel.fromJson(subMovie))
          .toList(),
    );
  }

  MovieDetail toEntity() {
    return MovieDetail(
      id: id,
      categoryCode: categoryCode,
      name: name,
      description: description,
      totalLiked: totalLiked,
      totalBookmarked: totalBookmarked,
      isLiked: isLiked,
      isBookmarked: isBookmarked,
      isEnrolled: isEnrolled,
      progress: progress,
      thumbnail: thumbnail,
      trailerVideoUrl: trailerVideoUrl,
      subMovies: subMovies.map((subMovie) => subMovie.toEntity()).toList(),
    );
  }
}

class SubMovieModel {
  final String id;
  final String name;
  final String description;
  final List<MovieSegmentModel> movieSegments;

  SubMovieModel({
    required this.id,
    required this.name,
    required this.description,
    required this.movieSegments,
  });

  factory SubMovieModel.fromJson(Map<String, dynamic> json) {
    return SubMovieModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      movieSegments: (json['sub_movie'] as List)
          .map((segment) => MovieSegmentModel.fromJson(segment))
          .toList(),
    );
  }

  SubMovie toEntity() {
    return SubMovie(
      id: id,
      name: name,
      description: description,
      movieSegments: movieSegments.map((segment) => segment.toEntity()).toList(),
    );
  }
}

class MovieSegmentModel {
  final String id;
  final String name;
  final String videoUrl;
  final bool isCompleted;

  MovieSegmentModel({
    required this.id,
    required this.name,
    required this.videoUrl,
    required this.isCompleted,
  });

  factory MovieSegmentModel.fromJson(Map<String, dynamic> json) {
    return MovieSegmentModel(
      id: json['id'],
      name: json['name'],
      videoUrl: json['video_url'],
      isCompleted: json['is_completed'],
    );
  }

  MovieSegment toEntity() { // Changed return type
    return MovieSegment(
      id: id,
      name: name,
      videoUrl: videoUrl,
      isCompleted: isCompleted,
    );
  }
}