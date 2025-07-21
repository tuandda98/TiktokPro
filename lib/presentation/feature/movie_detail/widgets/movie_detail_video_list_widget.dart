import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants/icon_constants.dart';
import '../../../../core/widget_common/button/glassy_dropdown_button.dart';
import '../../../../core/widget_common/trophy_progress_indicator.dart';
import '../../../../domain/entities/movie_detail.dart';
import '../movie_detail_providers.dart';
import 'movie_detail_video_item_widget.dart';

class MovieDetailVideoList extends ConsumerStatefulWidget {
  final List<YoutubePlayerController> controllers;
  final List<Map<String, dynamic>> videoData;
  final MovieDetail movieDetail;

  const MovieDetailVideoList({
    super.key,
    required this.controllers,
    required this.videoData,
    required this.movieDetail,
  });

  @override
  ConsumerState<MovieDetailVideoList> createState() => _MovieDetailVideoListState();
}

class _MovieDetailVideoListState extends ConsumerState<MovieDetailVideoList> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movieDetailsNotifierProvider.notifier).updateCurrentMovieLabel(0, widget.videoData);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: widget.controllers.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
            ref.read(movieDetailsNotifierProvider.notifier)
                .updateCurrentMovieLabel(index, widget.videoData);

          },
          itemBuilder: (context, index) {
            return MovieDetailVideoItem(
              controller: widget.controllers[index],
              videoData: widget.videoData[index],
              movieDetail: widget.movieDetail,
            );
          },
        ),

        if (currentIndex < widget.videoData.length)
          Positioned(
            bottom: 36,
            left: 36,
            right: 36,
            child: GlassyNeumorphicButton(
              label: ref.read(movieDetailsNotifierProvider).currentMovieLabel,
              onTap: () async {
                if (currentIndex < widget.controllers.length) {
                  widget.controllers[currentIndex].pause();
                }

                final selectedMovieId = await showModalBottomSheet<String>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext sheetContext) {
                    return Container(
                      height: 700,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    widget.movieDetail.thumbnail,
                                    width: 46,
                                    height: 46,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 36,
                                        height: 36,
                                        color: AppColors.primaryBlack,
                                        child: const Icon(
                                          Icons.person,
                                          color: AppColors.white,
                                          size: 20,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    "Lorem Ipsum is simply dummy text",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                widget.movieDetail.isEnrolled
                                    ? TrophyProgressIndicator(
                                  progress: (widget.movieDetail.progress) / 100.0,
                                )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                color: AppColors.softTeal,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Lorem Ipsum is simply dummy text\nof the printing and typesetting industry. Lorem Ipsum has been the industry's standard",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(26),
                                        child: Image.network(
                                          widget.movieDetail.thumbnail,
                                          width: 26,
                                          height: 26,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              width: 36,
                                              height: 36,
                                              color: AppColors.primaryBlack,
                                              child: const Icon(
                                                Icons.person,
                                                color: AppColors.white,
                                                size: 20,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "What is Lorem Ipsum",
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Contrary to popular belief, ",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Divider(color: AppColors.primary, thickness: 1),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "I am  1: just a dummy of text？",
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: widget.movieDetail.progress * 0.01,
                              minHeight: 8,
                              backgroundColor: const Color(0xFFE6EBEB),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00B050)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: buildMovieScrollView(sheetContext))),
                        ],
                      ),
                    );
                  },
                );
                if (selectedMovieId == null) {
                  if (currentIndex < widget.controllers.length) {
                    widget.controllers[currentIndex].play();
                  }
                } else {
                  _navigateToMovie(selectedMovieId);
                }
              },
            ),
          ),
      ],
    );
  }

  void _navigateToMovie(String selectedMovieId) {
    int targetIndex = -1;
    int videoIndex = 0;

    // Skip trailer video (it's always at index 0)
    if (widget.videoData.isNotEmpty && widget.videoData[0]['type'] == 'trailer') {
      videoIndex = 1;
    }

    for (var movie in widget.movieDetail.subMovies) {
      for (var subMovie in movie.movieSegments) {
        if (subMovie.id == selectedMovieId) {
          targetIndex = videoIndex;
          break;
        }
        videoIndex++;
      }
      if (targetIndex != -1) break;
    }

    if (targetIndex != -1 && targetIndex != currentIndex) {
      pageController.animateToPage(
        targetIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildMovieScrollView(BuildContext sheetContext) {
    List<MovieSegment> allSegments = [];
    for (var subMovie in widget.movieDetail.subMovies) {
      allSegments.addAll(subMovie.movieSegments);
    }

    return ListView.separated(
      itemCount: allSegments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final subMovie = allSegments[index];

        return GestureDetector(
          onTap: () {
            Navigator.pop(sheetContext, subMovie.id);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.softTeal),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  subMovie.isCompleted ? IconConstants.checkButton : IconConstants.playButton,
                  width: 28,
                  height: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "${index + 1}/${allSegments.length}: ${subMovie.name}",
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}