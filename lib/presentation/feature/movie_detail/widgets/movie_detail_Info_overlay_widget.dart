import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';
import '../../../../domain/entities/movie.dart';

class MovieDetailInfoOverlay extends StatelessWidget {
  final Movie movie;
  final double bottom;

  const MovieDetailInfoOverlay({
    super.key,
    required this.movie,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    size: 20,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Text(
            movie.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
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
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}