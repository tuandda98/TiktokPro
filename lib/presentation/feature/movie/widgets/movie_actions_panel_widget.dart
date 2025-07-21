
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/icon_constants.dart';
import '../../../../core/widget_common/button/app_button.dart';
import '../../../../core/widget_common/trophy_progress_indicator.dart';
import '../../../../domain/entities/movie.dart';

class MovieActionsPanel extends StatefulWidget {
  final Movie movie;
  final double? bottom;

  const MovieActionsPanel({
    super.key,
    required this.movie,
    this.bottom = 40,
  });

  @override
  State<MovieActionsPanel> createState() => _MovieActionsPanelState();
}

class _MovieActionsPanelState extends State<MovieActionsPanel> {
  late bool isLiked;
  late bool isBookmarked;
  late int totalLiked;
  late int totalBookmarked;

  double? get bottomPadding => widget.bottom;

  @override
  void initState() {
    super.initState();
    isLiked = widget.movie.isLiked;
    isBookmarked = widget.movie.isBookmarked;
    totalLiked = widget.movie.totalLiked;
    totalBookmarked = widget.movie.totalBookmarked;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      totalLiked += isLiked ? 1 : -1;
    });
  }

  void _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
      totalBookmarked += isBookmarked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: widget.bottom,
      child: Column(
        children: [
          // Like Button
          AppActionButton(
            svgIcon: IconConstants.like,
            label: '$totalLiked',
            color: isLiked ? Colors.red : Colors.white,
            width: 30,
            height: 30,
            onTap: _toggleLike,
          ),
          const SizedBox(height: 20),

          // Bookmark Button
          AppActionButton(
            svgIcon: IconConstants.bookmarks,
            label: '$totalBookmarked',
            color: isBookmarked ? Colors.yellow : Colors.white,
            width: 30,
            height: 30,
            onTap: _toggleBookmark,
          ),
          const SizedBox(height: 20),

          widget.movie.isEnrolled ? TrophyProgressIndicator(
            progress: (widget.movie.progress) / 100.0,
          ) : const SizedBox(height: 80),
        ],
      ),
    );
  }
}