import 'package:flutter/cupertino.dart';
import 'package:widget_common/presentation/feature/movie/widgets/process_bar_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatelessWidget {
  final YoutubePlayerController controller;
  final bool showVideoProgressIndicator;
  final double? bottomProgressIndicator;

  const VideoPlayerWidget({
    super.key,
    required this.controller,
    this.showVideoProgressIndicator = true,
    this.bottomProgressIndicator = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 9 / 16, // Adjust aspect ratio as needed
            child: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: false, // Disable built-in
            ),
          ),

          // Custom Progress Bar
          if (showVideoProgressIndicator)
            Positioned(
              bottom: bottomProgressIndicator,
              left: 16,
              right: 16,
              child: VideoProgressBar(controller: controller),
            ),
        ],
      ),
    );
  }
}