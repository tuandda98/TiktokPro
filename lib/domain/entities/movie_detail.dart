class MovieDetail {
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
  final List<SubMovie> subMovies;

  MovieDetail({
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
}

class SubMovie {
  final String id;
  final String name;
  final String description;
  final List<MovieSegment> movieSegments;

  SubMovie({
    required this.id,
    required this.name,
    required this.description,
    required this.movieSegments,
  });
}

class MovieSegment {
  final String id;
  final String name;
  final String videoUrl;
  final bool isCompleted;

  MovieSegment({
    required this.id,
    required this.name,
    required this.videoUrl,
    required this.isCompleted,
  });
}