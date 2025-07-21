import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' show ImageFilter;

class ExpandableCategoryChip extends StatelessWidget {
  final bool isSelected;
  final String iconAsset;
  final String? label;
  final Color backgroundColor;
  final Color backgroundColorNotSelected;
  final Color textColor;
  final VoidCallback onTap;

  const ExpandableCategoryChip({
    super.key,
    required this.isSelected,
    required this.iconAsset,
    this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    required this.backgroundColorNotSelected
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? backgroundColor : backgroundColorNotSelected,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              // Enhanced shadows when selected
              BoxShadow(
                color: const Color(0x1F000000),
                offset: const Offset(0, 1),
                blurRadius: isSelected ? 8 : 5,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0x1A000000),
                offset: const Offset(0, 0),
                blurRadius: isSelected ? 4 : 2,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0xFFF2F2F2),
                offset: const Offset(0, 0),
                blurRadius: isSelected ? 20 : 16,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0x6E999999),
                offset: const Offset(0, 0),
                blurRadius: isSelected ? 8 : 5,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0x26FFFFFF),
                offset: const Offset(0, 0),
                blurRadius: isSelected ? 40 : 33,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0x33B3B3B3),
                offset: const Offset(-3, -2.5),
                blurRadius: isSelected ? 2 : 1.5,
                spreadRadius: -3,
              ),
              BoxShadow(
                color: const Color(0x33B3B3B3),
                offset: const Offset(3, 2.5),
                blurRadius: isSelected ? 2 : 1.5,
                spreadRadius: -3,
              ),
              BoxShadow(
                color: const Color(0x4DFFFFFF),
                offset: const Offset(-1, -1),
                blurRadius: isSelected ? 1.5 : 1,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: const Color(0x4DFFFFFF),
                offset: const Offset(1, 1),
                blurRadius: isSelected ? 1.5 : 1,
                spreadRadius: -2,
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(26),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  iconAsset,
                  width: 34,
                  height: 34,
                ),
                if (isSelected && label != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    label!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}