import '../entities/movie.dart';
import '../repository/course_repository.dart';
import '../common/result.dart';
import '../../core/error/failure.dart';

class GetListMovieUseCase {
  final MovieRepository repository;

  GetListMovieUseCase(this.repository);

  Future<Result<List<Movie>, Failure>> call({int page = 1, int limit = 10}) => repository.getListMovie( page: page, limit: limit);
}