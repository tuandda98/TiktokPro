import 'dart:ui';
import 'package:flutter/material.dart';

class GlassyNeumorphicButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const GlassyNeumorphicButton({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                // Outer shadows
                const BoxShadow(
                  color: Color(0x1F000000), // #0000001F
                  offset: Offset(0, 1),
                  blurRadius: 5,
                ),
                const BoxShadow(
                  color: Color(0x1A000000), // #0000001A
                  offset: Offset(0, 0),
                  blurRadius: 2,
                ),
                // Inner shadows
                const BoxShadow(
                  color: Color(0x26FFFFFF),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: const Color(0x6E999999), // #9999996E
                  blurRadius: 5,
                ),
                BoxShadow(
                  color: const Color(0x26FFFFFF), // #FFFFFF26
                  blurRadius: 33,
                ),
                BoxShadow(
                  color: const Color(0x33B3B3B3), // #B3B3B333
                  offset: const Offset(-3, -2.5),
                  blurRadius: 1.5,
                  spreadRadius: -3,
                ),
                BoxShadow(
                  color: const Color(0x33B3B3B3), // #B3B3B333
                  offset: const Offset(3, 2.5),
                  blurRadius: 1.5,
                  spreadRadius: -3,
                ),
                BoxShadow(
                  color: const Color(0x33B3B3B3), // #FFFFFF4D
                  offset: const Offset(-1, -1),
                  blurRadius: 1.5,
                  spreadRadius: -2.25,
                ),
                BoxShadow(
                  color: const Color(0x33B3B3B3), // #FFFFFF4D
                  offset: const Offset(1, 1),
                  blurRadius: 1.5,
                  spreadRadius: -2.25,
                ),
              ],
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.video_library_outlined, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
