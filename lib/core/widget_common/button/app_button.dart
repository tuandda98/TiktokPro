import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppActionButton extends StatelessWidget {
  final String? svgIcon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final double? iconSize;
  final double? width;
  final double? height;


  const AppActionButton({
    super.key,
    this.svgIcon,
    required this.label,
    required this.onTap,
    this.color = Colors.white,
    this.iconSize = 24,
    this.width = 24,
    this.height = 26,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
            SvgPicture.asset(
              svgIcon!,
              width: width,
              height: height,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
