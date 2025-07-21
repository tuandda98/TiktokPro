import '../../core/error/failure.dart';
import '../common/result.dart';
import '../entities/movie_detail.dart';
import '../repository/course_repository.dart';

class GetMovieDetailUseCase {
  final MovieRepository repository;

  GetMovieDetailUseCase(this.repository);

  Future<Result<MovieDetail, Failure>> call(String movieId) => repository.getMovieById(movieId);
}