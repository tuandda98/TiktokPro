import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/usecase_providers.dart';
import 'viewmodel/movie_notifier.dart';
import 'viewmodel/movie_state.dart';

final movieNotifierProvider = StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  final usecase = ref.watch(getMovieUseCaseProvider);
  return MovieNotifier(usecase);
});



