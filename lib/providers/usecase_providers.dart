
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_movie_usecase.dart';
import '../domain/usecases/get_movie_detail_usecase.dart';
import 'repo_providers.dart';

final getMovieUseCaseProvider = Provider((ref) {
  final repo = ref.watch(movieRepositoryProvider);
  return GetListMovieUseCase(repo);
});

final getMovieDetailUseCaseProvider = Provider((ref) {
  final repo = ref.watch(movieRepositoryProvider);
  return GetMovieDetailUseCase(repo);
});