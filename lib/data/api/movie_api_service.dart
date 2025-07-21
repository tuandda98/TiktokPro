import 'dart:convert';

import '../../core/error/exception_mapper.dart';
import '../../core/error/failure.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/constants/api_constants.dart';
import '../../core/utils/constants/error_constants.dart';
import '../../core/utils/logger.dart';
import '../mock/movie_response.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';

class MovieApiService {
  final ApiClient apiClient;
  MovieApiService(this.apiClient);

  Future<MovieResponse> getListMovie({int page = 1, int limit = 10}) async {
    try {
      final response = await apiClient.get('${ApiConstants.getMovies}?page=$page&limit=$limit');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return MovieResponse.fromJson(data);
      } else {
        final failure = APIFailure(
          ErrorConstants.apiError,
          response.statusCode,
          response.body,
        );
        logError(failure);
        throw failure;
      }
    } catch (e) {
      final failure = mapException(e);
      logError(failure);
      return _generateMockmovieResponse(page: page, limit: limit);
    }
  }

  MovieResponse _generateMockmovieResponse({int page = 1, int limit = 10}) {
    const int totalItems = 100;
    final int totalPages = (totalItems / limit).ceil();
    final int startIndex = (page - 1) * limit;

    final List<String> categories = ["ideas", "tech", "design", "business", "marketing", "health"];
    final List<String> thumbnails = [
      "https://tinypng.com/images/social/website.jpg",
      "https://picsum.photos/400/300?random=1",
      "https://picsum.photos/400/300?random=2",
      "https://picsum.photos/400/300?random=3",
    ];
    final List<String> videoUrls = [
      "https://www.youtube.com/shorts/Mf9GCn_LsUI",
      "https://www.youtube.com/shorts/kde7aaHrQl4",
      "https://www.youtube.com/shorts/frnYsyMAUxg",
      "https://www.youtube.com/shorts/r2MAGoQDI3U",
      "https://www.youtube.com/shorts/2rm-FpLIuX0",
      "https://www.youtube.com/shorts/ZSFvbjDnbX0",
      "https://www.youtube.com/shorts/BWV6Iq3m4q0",
    ];

    final List<MovieModel> movies = List.generate(limit, (index) {
      final movieNumber = startIndex + index + 1;
      if (movieNumber > totalItems) return null;

      final categoryIndex = (movieNumber - 1) % categories.length;
      final thumbnailIndex = (movieNumber - 1) % thumbnails.length;
      final videoIndex = (movieNumber - 1) % videoUrls.length;

      return MovieModel(
        id: "CRS${movieNumber.toString().padLeft(4, '0')}",
        categoryCode: categories[categoryIndex],
        name: "Movie ${movieNumber.toString().padLeft(2, '0')}",
        description: "Lorem Ipsum is simply dummy text, ${movieNumber.toString().padLeft(2, '0')}",
        totalLiked: 50 + (movieNumber * 13) % 500,
        totalBookmarked: 10 + (movieNumber * 7) % 100,
        isLiked: movieNumber % 3 == 0,
        isBookmarked: movieNumber % 4 == 0,
        isEnrolled: movieNumber % 5 == 0,
        progress: movieNumber % 5 == 0 ? (movieNumber * 20) % 100 : 0,
        thumbnail: thumbnails[thumbnailIndex],
        trailerVideoUrl: videoUrls[videoIndex],
      );
    }).where((movie) => movie != null).cast<MovieModel>().toList();

    return MovieResponse(
      movies: movies,
      currentPage: page,
      totalPages: totalPages,
      totalItems: totalItems,
      hasNext: page < totalPages,
    );
  }

  Future<MovieDetailModel> getmovieById(String movieId) async {
    try {
      final response = await apiClient.get(ApiConstants.getmovieDetailsUrl(movieId));

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return MovieDetailModel.fromJson(data);
      } else {
        final failure = APIFailure(
          ErrorConstants.apiError,
          response.statusCode,
          response.body,
        );
        logError(failure);
        throw failure;
      }
    } catch (e) {
      final failure = mapException(e);
      logError(failure);
      return MovieDetailModel(
        id: movieId,
        categoryCode: "ideas",
        name: "Movie 01",
        description: "Movie 01 description",
        totalLiked: 122,
        totalBookmarked: 35,
        isLiked: true,
        isBookmarked: true,
        isEnrolled: true,
        progress: 30.0,
        thumbnail: "https://tinypng.com/images/social/website.jpg",
        trailerVideoUrl: "https://www.youtube.com/shorts/Mf9GCn_LsUI",
        subMovies: [
          SubMovieModel(
            id: "LS001",
            name: "Movie 01",
            description: "Movie 01 description",
            movieSegments: [
              MovieSegmentModel(
                id: "LS0011",
                name: "Movie 01 Part 1",
                videoUrl: "https://www.youtube.com/shorts/2rm-FpLIuX0",
                isCompleted: true,
              ),
              MovieSegmentModel(
                id: "LS0012",
                name: "Movie 01 Part 2",
                videoUrl: "https://www.youtube.com/shorts/ZSFvbjDnbX0",
                isCompleted: false,
              ),
              MovieSegmentModel(
                id: "LS0013",
                name: "Movie 01 Part 3",
                videoUrl: "https://www.youtube.com/shorts/BWV6Iq3m4q0",
                isCompleted: false,
              ),
              MovieSegmentModel(
                id: "LS0014",
                name: "Movie 01 Part 4",
                videoUrl: "https://www.youtube.com/shorts/cHrJP09Iya4",
                isCompleted: false,
              ),
              MovieSegmentModel(
                id: "LS0015",
                name: "Movie 01 Part 5",
                videoUrl: "https://www.youtube.com/shorts/82Dord7SFmE",
                isCompleted: false,
              ),
              MovieSegmentModel(
                id: "LS0016",
                name: "Movie 01 Part 6",
                videoUrl: "https://www.youtube.com/shorts/juuh1ddcIpA",
                isCompleted: false,
              ),
            ],
          ),
        ],
      );
    }
  }
}