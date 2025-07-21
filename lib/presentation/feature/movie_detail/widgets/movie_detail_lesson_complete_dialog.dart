import 'package:flutter/material.dart';
import 'package:widget_common/core/utils/constants/icon_constants.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widget_common/trophy_progress_indicator.dart';

class MovieCompletedDialog extends StatelessWidget {
  final String movieTitle;
  final String thumbnailUrl;
  final double progress;
  final int totalSubMovies;
  final int completedSubMovies;

  const MovieCompletedDialog({
    super.key,
    required this.movieTitle,
    required this.thumbnailUrl,
    required this.progress,
    required this.totalSubMovies,
    required this.completedSubMovies,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title Row
                  Row(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              thumbnailUrl,
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 44,
                                  height: 44,
                                  color: AppColors.primaryBlack,
                                  child: const Icon(Icons.person,
                                      color: AppColors.white, size: 20),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: movieTitle
                              .split(':')
                              .map((part) => Text(
                                    part.trim(),
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      TrophyProgressIndicator(progress: progress / 100.0),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 41,
                          child: Image.asset(
                            IconConstants.participant,
                            width: 30,
                            height: 30,
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(
                          width: 45,
                          height: 41,
                          child: Image.asset(
                            IconConstants.participants,
                            width: 30,
                            height: 30,
                            colorBlendMode: BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalSubMovies * 2 - 1, (index) {
                        if (index.isEven) {
                          // This is a dot
                          int dotIndex = index ~/ 2;
                          bool isCompleted = dotIndex < completedSubMovies;
                          return Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? AppColors.primary
                                  : Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          );
                        } else {
                          // This is a dash - dynamic width based on available space
                          return Expanded(
                            child: Container(
                              height: 2,
                              color: Colors.grey.shade400,
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void show({
    required BuildContext context,
    required String movieTitle,
    required String thumbnailUrl,
    required double progress,
    required int totalSubmovies,
    required int completedSubmovies,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return MovieCompletedDialog(
          movieTitle: movieTitle,
          thumbnailUrl: thumbnailUrl,
          progress: progress,
          totalSubMovies: totalSubmovies,
          completedSubMovies: completedSubmovies,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child,
        );
      },
    );
  }
}
