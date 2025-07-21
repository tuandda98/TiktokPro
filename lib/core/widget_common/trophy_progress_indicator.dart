import 'package:flutter/material.dart';

class TrophyProgressIndicator extends StatelessWidget {
  final double size;
  final double progress; // from 0.0 to 1.0

  const TrophyProgressIndicator({
    super.key,
    this.size = 48,
    this.progress = 0.75, // example: 75% complete
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background gray circle
          CircularProgressIndicator(
            value: 1.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade400),
            strokeWidth: 5,
          ),

          // Foreground green progress
          CircularProgressIndicator(
            value: progress,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            backgroundColor: Colors.transparent,
            strokeWidth: 5,
          ),

          // Trophy icon
          Icon(
            Icons.emoji_events, // Material trophy icon
            size: size * 0.5,
            color: Colors.amber.shade600,
          ),
        ],
      ),
    );
  }
}
