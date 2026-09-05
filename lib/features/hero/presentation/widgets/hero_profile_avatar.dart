import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/app_assets.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';

class HeroProfileAvatar extends StatelessWidget {
  const HeroProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final radius = screenWidth < 850
        ? 80.0
        : (screenWidth < 1200 ? 100.0 : 130.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppColors.primaryLight : AppColors.primaryDark;

    return FloatingWidget(
      amplitude: 14,
      duration: const Duration(seconds: 4),
      child: TiltCard(
        maxTilt: 20,
        scale: 1.0,
        glareOpacity: 0.2,
        borderRadius: BorderRadius.circular(500),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.4),
                blurRadius: 40,
                spreadRadius: 8,
                offset: const Offset(0, 20),
              ),
              BoxShadow(
                color: primaryColor.withValues(alpha: 0.15),
                blurRadius: 80,
                spreadRadius: 20,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: primaryColor,
            child: CircleAvatar(
              radius: radius - 4,
              backgroundColor: isDark
                  ? AppColors.darkBackground
                  : Colors.white,
              child: CircleAvatar(
                radius: radius - 12,
                backgroundImage: AssetImage(AppAssets.profileAvatar),
              ).animate().scale(
                    delay: 300.ms,
                    duration: 800.ms,
                    curve: Curves.elasticOut,
                  ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 800.ms);
  }
}
