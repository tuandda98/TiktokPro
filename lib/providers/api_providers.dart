import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/api/movie_api_service.dart';
import '../core/network/api_client.dart';

final apiClientProvider = Provider((ref) => ApiClient());

final movieApiProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MovieApiService(apiClient);
});
