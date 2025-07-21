class Movie {
  final String id;
  final String categoryCode;
  final String name;
  final String description;
  final int totalLiked;
  final int totalBookmarked;
  final bool isLiked;
  final bool isBookmarked;
  final bool isEnrolled;
  final int progress;
  final String thumbnail;
  final String trailerVideoUrl;

  Movie({
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
  });
}