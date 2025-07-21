import 'package:flutter/material.dart';
import 'package:widget_common/presentation/feature/movie/widgets/video_player_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../domain/entities/movie.dart';
import 'movie_Info_overlay_widget.dart';
import 'movie_actions_panel_widget.dart';


class VideoListWidget extends StatelessWidget {
  final List<YoutubePlayerController> controllers;
  final List<Movie> movies;
  final bool showVideoProgressIndicator;
  final PageController? pageController;
  final Function(int)? onPageChanged;

  const VideoListWidget({
    super.key,
    required this.controllers,
    required this.movies,
    this.showVideoProgressIndicator = true,
    this.pageController,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      scrollDirection: Axis.vertical,
      itemCount: controllers.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return MovieVideoWidget(
          controller: controllers[index],
          movie: movies[index],
        );
      },
    );
  }
}

class MovieVideoWidget extends StatelessWidget {
  final YoutubePlayerController controller;
  final Movie movie;

  const MovieVideoWidget({
    super.key,
    required this.controller,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: VideoPlayerWidget(controller: controller),
        ),
        MovieInfoOverlay(movie: movie),
        MovieActionsPanel(movie: movie),
      ],
    );
  }
}




