import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/constants/icon_constants.dart';
import '../../../../core/utils/colors.dart';

List<BottomNavigationBarItem> get homeBottomNavItems => [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home, size: 26),
    label: '',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      IconConstants.learn,
      width: 24,
      height: 26,
      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    activeIcon: SvgPicture.asset(
      IconConstants.learn,
      width: 24,
      height: 26,
      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
    ),
    label: '',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      IconConstants.friends,
      width: 24,
      height: 26,
      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    activeIcon: SvgPicture.asset(
      IconConstants.friends,
      width: 24,
      height: 26,
      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
    ),
    label: '',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      IconConstants.pet,
      width: 24,
      height: 26,
      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    activeIcon: SvgPicture.asset(
      IconConstants.pet,
      width: 24,
      height: 26,
      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
    ),
    label: '',
  ),
  BottomNavigationBarItem(
    icon: SvgPicture.asset(
      IconConstants.profile,
      width: 24,
      height: 26,
      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    ),
    activeIcon: SvgPicture.asset(
      IconConstants.profile,
      width: 24,
      height: 26,
      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
    ),
    label: '',
  )
];