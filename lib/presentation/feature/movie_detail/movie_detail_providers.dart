import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_common/presentation/feature/movie_detail/viewmodel/movie_details_notifier.dart';
import 'package:widget_common/presentation/feature/movie_detail/viewmodel/movie_details_state.dart';

import '../../../providers/usecase_providers.dart';

final movieDetailsNotifierProvider = StateNotifierProvider<MovieDetailsNotifier, MovieDetailsState>((ref) {
  final usecase = ref.watch(getMovieDetailUseCaseProvider);
  return MovieDetailsNotifier(usecase);
});



