import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../domain/entities/movie_detail.dart';
import '../../movie/widgets/movie_actions_panel_widget.dart';
import '../../movie/widgets/video_player_widget.dart';
import '../movie_detail_providers.dart';
import 'movie_detail_Info_overlay_widget.dart';
import 'movie_detail_lesson_complete_dialog.dart';
import 'movie_overlay_widget.dart';

class MovieDetailVideoItem extends ConsumerStatefulWidget {
  final YoutubePlayerController controller;
  final Map<String, dynamic> videoData;
  final MovieDetail movieDetail;

  const MovieDetailVideoItem({
    super.key,
    required this.controller,
    required this.videoData,
    required this.movieDetail,
  });

  @override
  ConsumerState<MovieDetailVideoItem> createState() => _MovieDetailVideoItemState();
}

class _MovieDetailVideoItemState extends ConsumerState<MovieDetailVideoItem> {
  bool _hasShownCompletionDialog = false;

  @override
  void initState() {
    super.initState();
    _setupVideoListener();
  }

  void _setupVideoListener() {
    widget.controller.addListener(() {
      final isTrailer = widget.videoData['type'] == 'trailer';

      if (!isTrailer) {
        final duration = widget.controller.value.metaData.duration.inSeconds;
        final position = widget.controller.value.position.inSeconds;

        // Reset flag when video restarts (position is near beginning)
        if (position < 5 && _hasShownCompletionDialog) {
          _hasShownCompletionDialog = false;
        }

        // Show dialog when video completes
        if (!_hasShownCompletionDialog && duration > 0 && position / duration >= 0.95) {
          _showMovieCompletedDialog();
        }
      }
    });
  }
  void _showMovieCompletedDialog() {
    final movieState = ref.read(movieDetailsNotifierProvider);
    _hasShownCompletionDialog = true;
    widget.controller.pause();
    MovieCompletedDialog.show(
      context: context,
      movieTitle: movieState.currentMovieLabel,
      thumbnailUrl: widget.movieDetail.thumbnail,
      progress: widget.movieDetail.progress ,
      totalSubmovies: movieState.movieDetail?.subMovies[0].movieSegments.length ?? 0,
      completedSubmovies: int.parse(movieState.currentMovieLabel.split(':')[1].split("/")[0].replaceAll(RegExp(r'[^0-9]'), '')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTrailer = widget.videoData['type'] == 'trailer';

    return Stack(
      children: [
        Positioned.fill(
          child: VideoPlayerWidget(
            controller: widget.controller,
            showVideoProgressIndicator: true,
            bottomProgressIndicator: 100,
          ),
        ),

        if (isTrailer) ...[
          MovieDetailInfoOverlay(
            movie: _createMovieFromDetail(),
            bottom: 120,
          ),
          MovieActionsPanel(
            movie: _createMovieFromDetail(),
            bottom: 120,
          ),
        ],
        if (!isTrailer) ...[
          MovieOverlay(
            videoData: widget.videoData,
            movieDetail: widget.movieDetail,
            bottom: 120,
          ),
        ],
      ],
    );
  }

  Movie _createMovieFromDetail() {
    return Movie(
      id: widget.movieDetail.id,
      categoryCode: widget.movieDetail.categoryCode,
      name: widget.movieDetail.name,
      description: widget.videoData['description'] ?? widget.movieDetail.description,
      totalLiked: widget.movieDetail.totalLiked,
      totalBookmarked: widget.movieDetail.totalBookmarked,
      isLiked: widget.movieDetail.isLiked,
      isBookmarked: widget.movieDetail.isBookmarked,
      isEnrolled: widget.movieDetail.isEnrolled,
      progress: widget.movieDetail.progress.toInt(),
      thumbnail: widget.movieDetail.thumbnail,
      trailerVideoUrl: widget.movieDetail.trailerVideoUrl,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}