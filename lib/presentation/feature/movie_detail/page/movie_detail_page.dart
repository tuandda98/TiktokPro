import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants/icon_constants.dart';
import '../../../../core/utils/video_extension.dart';
import '../movie_detail_providers.dart';
import '../widgets/movie_detail_video_list_widget.dart';

class MovieDetailPage extends ConsumerStatefulWidget {
  final String movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  ConsumerState<MovieDetailPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends ConsumerState<MovieDetailPage> {
  List<YoutubePlayerController> _controllers = [];
  List<Map<String, dynamic>> _videoData = [];
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movieDetailsNotifierProvider.notifier).loadMovieDetail(widget.movieId);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers(List<String> videoUrls, List<Map<String, dynamic>> videoData) {
    for (var controller in _controllers) {
      controller.dispose();
    }

    _controllers = videoUrls.map((url) {
      final videoId = getVideoId(url);
      return videoId != null ? createController(videoId) : null;
    }).whereType<YoutubePlayerController>().toList();

    _videoData = videoData;
  }

  void _prepareVideoData(movieDetail) {
    List<String> videoUrls = [];
    List<Map<String, dynamic>> videoData = [];

    // Add trailer video first
    if (movieDetail.trailerVideoUrl.isNotEmpty) {
      videoUrls.add(movieDetail.trailerVideoUrl);
      videoData.add({
        'title': movieDetail.name,
        'description': movieDetail.description,
        'type': 'trailer',
        'isCompleted': false,
      });
    }

    for (var subMovie in movieDetail.subMovies) {
      for (var segment in subMovie.movieSegments) {
        if (segment.videoUrl.isNotEmpty) {
          videoUrls.add(segment.videoUrl);
          videoData.add({
            'title': segment.name,
            'description': 'From ${subMovie.name}',
            'type': 'segment',
            'isCompleted': segment.isCompleted,
            'subMovieName': subMovie.name,
          });
        }
      }
    }

    _initializeControllers(videoUrls, videoData);
  }

  @override
  Widget build(BuildContext context) {
    final movieDetailsState = ref.watch(movieDetailsNotifierProvider);

    if (movieDetailsState.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (movieDetailsState.error != null) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: AppColors.white, size: 48),
              const SizedBox(height: 16),
              Text(
                'Failed to load movie details',
                style: const TextStyle(color: AppColors.white, fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(movieDetailsNotifierProvider.notifier).loadMovieDetail(widget.movieId),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (movieDetailsState.movieDetail == null) {
      return const Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: Text(
            'No movie data available',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      );
    }

    // Initialize controllers if not already done
    if (!_initialized) {
      _initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _prepareVideoData(movieDetailsState.movieDetail!);
        setState(() {});
      });
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Video List
          if (_controllers.isNotEmpty)
            MovieDetailVideoList(
              controllers: _controllers,
              videoData: _videoData,
              movieDetail: movieDetailsState.movieDetail!,
            ),

          Positioned(
            top: 50,
            left: 16,
            child: Row(
              children: [
                const SizedBox(width: 4),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.bgColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    iconSize: 20,
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(40, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back, color: AppColors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 44),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    children: [
                      Image.asset(
                        IconConstants.chinaIcon,
                        width: 30,
                        height: 30,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      const SizedBox(width: 8),
                      Text("Where does it come from? ",
                        style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}