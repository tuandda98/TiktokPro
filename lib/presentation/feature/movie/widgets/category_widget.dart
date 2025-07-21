import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants/icon_constants.dart';
import '../../../../core/widget_common/expandable_category_chip.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {
      'label': 'ทั้งหมด',
      'icon': IconConstants.languageMovie,
      'bgColor': AppColors.accent,
      'textColor': AppColors.black,
      'bgColorNotSelected': const Color(0xFFDAD9C9),
    },
    {
      'label': 'ภาษา',
      'icon': IconConstants.musicMovie,
      'bgColor': AppColors.blue,
      'textColor': Colors.black,
      'bgColorNotSelected': const Color(0x1A43B1FF),
    },
    {
      'label': 'ดนตรี',
      'icon': IconConstants.businessMovie,
      'bgColor': const Color(0xFFFF6368),
      'textColor': Colors.black,
      'bgColorNotSelected': const Color(0x1AFF6368),
    },
    {
      'label': 'ธุรกิจ',
      'icon': IconConstants.selfDevelopment,
      'bgColor': const Color(0xFF3F61EA),
      'textColor': Colors.black,
      'bgColorNotSelected': const Color(0x99FFFFFF),
    },
    {
      'label': 'แนวคิด',
      'icon': IconConstants.frameMovie,
      'bgColor': const Color(0xFFEEFFA8),
      'textColor': Colors.black,
      'bgColorNotSelected': Colors.white,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 58,
      right: 54,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFB3BDC1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                width: 0.5,
                color: Colors.transparent,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.22),
                  Colors.white.withOpacity(0.0),
                ],
                stops: const [0.0, 0.3],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x1F000000),
                  offset: const Offset(0, 1),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0x1A000000),
                  offset: const Offset(0, 0),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0xFFF2F2F2),
                  offset: const Offset(0, 0),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0x6E999999),
                  offset: const Offset(0, 0),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0x26FFFFFF),
                  offset: const Offset(0, 0),
                  blurRadius: 33,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0x33B3B3B3),
                  offset: const Offset(-3, -2.5),
                  blurRadius: 1.5,
                  spreadRadius: -3,
                ),
                BoxShadow(
                  color: const Color(0x33B3B3B3),
                  offset: const Offset(3, 2.5),
                  blurRadius: 1.5,
                  spreadRadius: -3,
                ),
                BoxShadow(
                  color: const Color(0x4DFFFFFF),
                  offset: const Offset(-1, -1),
                  blurRadius: 1.5,
                  spreadRadius: -2.25,
                ),
                BoxShadow(
                  color: const Color(0x4DFFFFFF),
                  offset: const Offset(1, 1),
                  blurRadius: 1.5,
                  spreadRadius: -2.25,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  width: 0.5,
                  color: Colors.transparent,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.22),
                    Colors.white.withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.3],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      final cat = categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: ExpandableCategoryChip(
                          isSelected: selectedIndex == index,
                          label: cat['label'],
                          iconAsset: cat['icon'],
                          backgroundColor: cat['bgColor'],
                          backgroundColorNotSelected: cat['bgColorNotSelected'],
                          textColor: cat['textColor'],
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
