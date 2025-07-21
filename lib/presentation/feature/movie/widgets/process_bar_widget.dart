import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/utils/colors.dart';

class VideoProgressBar extends StatelessWidget {
  final YoutubePlayerController controller;

  const VideoProgressBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<YoutubePlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final duration = value.metaData.duration.inSeconds;
        final position = value.position.inSeconds;
        final progress = duration > 0 ? position / duration : 0.0;

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: progress.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 300),
          builder: (context, animatedProgress, _) {
            return Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white.withOpacity(0.3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: animatedProgress,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            );
          },
        );
      },
    );
  }
}