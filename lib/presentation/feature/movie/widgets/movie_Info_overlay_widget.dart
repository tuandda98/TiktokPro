import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants/icon_constants.dart';
import '../../../../domain/entities/movie.dart';
import '../../movie_detail/page/movie_detail_page.dart';

class MovieInfoOverlay extends StatelessWidget {
  final Movie movie;

  const MovieInfoOverlay({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(44),
                child: Image.network(
                  movie.thumbnail,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 36,
                      height: 36,
                      color: AppColors.primaryBlack,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.white,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Text(
                movie.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            movie.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: movie.id),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    IconConstants.playlist,
                    width: 26,
                    height: 26,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    movie.isEnrolled ? 'Continue Learning' : 'Register Now',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

        ],
      ),
    );
  }
}