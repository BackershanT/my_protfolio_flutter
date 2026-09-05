import 'package:flutter/material.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';

class FloatingCubesOverlay extends StatelessWidget {
  final double screenWidth;
  final bool isDark;

  const FloatingCubesOverlay({
    super.key,
    required this.screenWidth,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: screenWidth * 0.08,
          child: FloatingWidget(
            amplitude: 15,
            duration: const Duration(seconds: 5),
            child: RotatingCube(
              size: 38,
              color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          right: screenWidth * 0.06,
          child: FloatingWidget(
            amplitude: 12,
            duration: const Duration(seconds: 7),
            child: RotatingCube(
              size: 28,
              color: isDark ? Colors.purpleAccent : Colors.blue,
            ),
          ),
        ),
        Positioned(
          top: 200,
          right: screenWidth * 0.15,
          child: FloatingWidget(
            amplitude: 8,
            duration: const Duration(seconds: 6),
            child: RotatingCube(
              size: 20,
              color: isDark ? Colors.cyanAccent : Colors.indigo,
            ),
          ),
        ),
      ],
    );
  }
}
