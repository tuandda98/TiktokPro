import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/utils/video_extension.dart';
import '../../../../core/widget_common/tiktok_pro_widget.dart';
import '../movie_providers.dart';
import '../widgets/category_widget.dart';
import '../widgets/video_list_widget.dart';

class MoviePage extends ConsumerStatefulWidget {
  const MoviePage({super.key});

  @override
  ConsumerState<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  List<YoutubePlayerController> _controllers = [];
  late PageController _pageController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movieNotifierProvider.notifier).loadMovie();
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  void _initializeControllers(List<String> videoUrls) {
    // Dispose existing controllers
    for (var controller in _controllers) {
      controller.dispose();
    }

    _controllers = videoUrls.map((url) {
      final videoId = getVideoId(url);
      return createController(videoId!);
    }).toList();
  }

  void _onRetry() {
    ref.read(movieNotifierProvider.notifier).loadMovie();
  }

  void _onPageChanged(int index) {
    final movieState = ref.read(movieNotifierProvider);

    // Load more when user is near the end (e.g., 3 items before the end)
    if (index >= movieState.movies.length - 3 &&
        movieState.hasNext &&
        !movieState.isLoading &&
        !_isLoadingMore) {
      _loadMoreMovies();
    }
  }

  void _loadMoreMovies() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    final movieState = ref.read(movieNotifierProvider);
    final nextPage = movieState.currentPage + 1;

    await ref.read(movieNotifierProvider.notifier).loadMovie(
      page: nextPage,
      isLoadMore: true,
    );

    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieState = ref.watch(movieNotifierProvider);

    // Initialize controllers when movies are loaded
    if (!movieState.isLoading && movieState.movies.isNotEmpty) {
      final videoUrls = movieState.movies
          .map((movie) => movie.trailerVideoUrl)
          .toList();

      // Only reinitialize if the number of movies changed
      if (_controllers.length != videoUrls.length) {
        _initializeControllers(videoUrls);
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: TikTokProWidget(
        isLoading: movieState.isLoading && movieState.movies.isEmpty,
        error: movieState.error,
        onRetry: _onRetry,
        child: Stack(
          children: [
            if (movieState.movies.isNotEmpty)
              PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: movieState.movies.length + (movieState.hasNext ? 1 : 0),
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  // Show loading indicator at the end if there are more items
                  if (index >= movieState.movies.length) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  return MovieVideoWidget(
                    controller: _controllers[index],
                    movie: movieState.movies[index],
                  );
                },
              ),
            // const Category(),
          ],
        ),
      ),
    );
  }
}