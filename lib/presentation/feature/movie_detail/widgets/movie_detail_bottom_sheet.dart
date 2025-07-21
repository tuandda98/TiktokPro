import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_common/domain/entities/movie_detail.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants/icon_constants.dart';
import '../../../../core/widget_common/trophy_progress_indicator.dart';


class MovieDetailBottomSheet extends StatelessWidget {
  final MovieDetail movieDetail;
  final Widget movieList;

  const MovieDetailBottomSheet({
    super.key,
    required this.movieDetail,
    required this.movieList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movieDetail.thumbnail,
                    width: 46,
                    height: 46,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 46,
                        height: 46,
                        color: AppColors.primaryBlack,
                        child: const Icon(Icons.person, color: AppColors.white, size: 20),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Lorem Ipsum is simply dummy text",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (movieDetail.isEnrolled)
                  TrophyProgressIndicator(progress: movieDetail.progress / 100.0),
              ],
            ),
            const SizedBox(height: 8),

            // Description Card
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.softTeal,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    "Contrary to popular belief, Lorem Ipsum is not simply random text.",
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
                      SvgPicture.asset(
                        IconConstants.frameMovie,
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "There are many variations of passages of Lorem Ipsum available",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "assages of Lorem Ipsum available",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            const Divider(color: AppColors.primary, thickness: 1),

            // Chapter Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Donate: If you use this site regularly and would like to help keep the site on the Internet",
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: movieDetail.progress * 0.01,
                minHeight: 8,
                backgroundColor: const Color(0xFFE6EBEB),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00B050)),
              ),
            ),

            const SizedBox(height: 16),
            movieList,
          ],
        ),
      ),
    );
  }
}
