import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repository/course_repository.dart';
import '../../domain/common/result.dart';
import '../../core/error/failure.dart';
import '../../core/error/exception_mapper.dart';
import '../api/movie_api_service.dart';
class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService api;

  MovieRepositoryImpl(this.api);

  @override
  Future<Result<List<Movie>, Failure>> getListMovie({int page = 1, int limit = 10}) async {
    try {
      final response = await api.getListMovie(page: page, limit: limit);
      final movies = response.movies.map((model) => model.toEntity()).toList();
      return Success(movies);
    } on Failure catch (failure) {
      return Error(failure);
    } catch (e) {
      return Error(mapException(e));
    }
  }

  @override
  Future<Result<MovieDetail, Failure>> getMovieById(String movieId) async {
    try {
      final movieDetailModel = await api.getmovieById(movieId);
      final movieDetail = movieDetailModel.toEntity();
      return Success(movieDetail);
    } on Failure catch (failure) {
      return Error(failure);
    } catch (e) {
      return Error(mapException(e));
    }
  }
}