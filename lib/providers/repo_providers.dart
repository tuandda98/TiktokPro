import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository_impl/movie_repository_impl.dart';
import '../domain/repository/course_repository.dart';
import 'api_providers.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final api = ref.watch(movieApiProvider);
  return MovieRepositoryImpl(api);
});
