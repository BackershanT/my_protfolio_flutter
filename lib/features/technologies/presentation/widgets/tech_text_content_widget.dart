import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/colors.dart';

class TechTextContentWidget extends StatelessWidget {
  final String subtitle;
  final String headline;
  final String description;

  const TechTextContentWidget({
    super.key,
    required this.subtitle,
    required this.headline,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    final smallTitleSize = isMobile ? 14.0 : (isTablet ? 15.0 : 16.0);
    final headlineSize = isMobile ? 24.0 : (isTablet ? 32.0 : 42.0);
    final bodySize = isMobile ? 14.0 : (isTablet ? 16.0 : 18.0);
    final titleSpacing = isMobile ? 15.0 : 20.0;
    final headlineSpacing = isMobile ? 16.0 : (isTablet ? 20.0 : 24.0);

    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.primaryLight
                : AppColors.primaryDark,
            fontSize: smallTitleSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
        SizedBox(height: titleSpacing),
        Text(
              headline,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: headlineSize,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : null,
              ),
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slide(
              begin: const Offset(0, 0.2),
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        SizedBox(height: headlineSpacing),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: bodySize,
            height: 1.7,
            color: Theme.of(
              context,
            ).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
          ),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
      ],
    );
  }
}
