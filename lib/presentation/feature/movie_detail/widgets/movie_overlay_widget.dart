import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
import '../../../../domain/entities/movie_detail.dart';

class MovieOverlay extends StatelessWidget {
  final Map<String, dynamic> videoData;
  final MovieDetail movieDetail;
  final double? bottom;

  const MovieOverlay({
    super.key,
    required this.videoData,
    required this.movieDetail,
    this.bottom = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: 16,
      right: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(44),
            child: Image.network(
              movieDetail.thumbnail,
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
                    size: 20,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            videoData['title'] ?? '',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            videoData['description'] ?? '',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}