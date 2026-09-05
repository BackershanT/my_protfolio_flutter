import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/features/hero/presentation/widgets/btn_3d.dart';

class HeroTextContent extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onDownloadResume;
  final VoidCallback onViewProjects;

  const HeroTextContent({
    super.key,
    required this.currentIndex,
    required this.onDownloadResume,
    required this.onViewProjects,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Glowing caption
        Text(
          'I am',
          style: TextStyle(
            fontSize: isMobile ? 12 : 14,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.primaryLight.withValues(alpha: 0.8)
                : AppColors.primaryDark.withValues(alpha: 0.7),
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideX(begin: -0.3, end: 0),
        const SizedBox(height: 12),
        // Large bold headline
        Text(
          AppTexts.heroName,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 32 : (isTablet ? 40 : 60),
                fontWeight: FontWeight.bold,
                height: 1.05,
                letterSpacing: -1.5,
                color: isDark ? AppColors.primaryLight : null,
                shadows: [
                  Shadow(
                    color: (isDark
                            ? AppColors.primaryLight
                            : AppColors.primaryDark)
                        .withValues(alpha: 0.3),
                    blurRadius: 30,
                  ),
                ],
              ),
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slide(
              begin: const Offset(0, 0.2),
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        SizedBox(height: isMobile ? 15 : 24),
        // Animated role switcher
        SizedBox(
          height: isMobile ? 50 : 70,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Text(
              AppTexts.heroRoles[currentIndex],
              key: ValueKey<int>(currentIndex),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: isMobile ? 20 : (isTablet ? 26 : 38),
                    fontWeight: FontWeight.w600,
                    color:
                        isDark ? AppColors.primaryLight : AppColors.primaryDark,
                    height: 1.2,
                  ),
            ),
          ),
        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        SizedBox(height: isMobile ? 20 : 30),
        // Description
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 700 : (isTablet ? 500 : double.infinity),
          ),
          child: Text(
            AppTexts.heroDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                  height: 1.7,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withValues(alpha: 0.8),
                ),
          ),
        )
            .animate()
            .fadeIn(delay: 800.ms, duration: 600.ms)
            .slide(
              begin: const Offset(0, 0.2),
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        SizedBox(height: isMobile ? 30 : 40),
        _buildActionButtons(context, isMobile, isDark),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isMobile, bool isDark) {
    return Wrap(
      spacing: isMobile ? 12 : 20,
      runSpacing: 16,
      children: [
        // Primary CTA
        Btn3D(
          onPressed: onDownloadResume,
          filled: true,
          isDark: isDark,
          label: AppTexts.resumeButtonText,
          isMobile: isMobile,
        ).animate().fadeIn(delay: 1000.ms, duration: 600.ms).scale(
              begin: const Offset(0.9, 0.9),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
        // Secondary CTA
        Btn3D(
          onPressed: onViewProjects,
          filled: false,
          isDark: isDark,
          label: AppTexts.viewProjects,
          isMobile: isMobile,
        ).animate().fadeIn(delay: 1200.ms, duration: 600.ms).scale(
              begin: const Offset(0.9, 0.9),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
      ],
    );
  }
}
