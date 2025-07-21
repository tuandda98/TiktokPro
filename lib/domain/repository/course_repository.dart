import '../entities/movie.dart';
import '../common/result.dart';
import '../../core/error/failure.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  Future<Result<List<Movie>, Failure>> getListMovie({int page = 1, int limit = 10});
  Future<Result<MovieDetail, Failure>> getMovieById(String movieId);
}