import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/about/data/models/about_data.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth < 850 ? 20 : (screenWidth < 1200 ? 40 : 100),
        vertical: screenWidth < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: AppTexts.aboutTitle),
          SizedBox(height: screenWidth < 850 ? 40 : 60),
          // Flutter.dev style: Feature cards
          Responsive(
            mobile: _buildMobileLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final features = AboutData.getAllFeatures();
    
    return Column(
      children: features
          .map((feature) => Padding(
                padding: EdgeInsets.only(bottom: screenWidth < 600 ? 20 : 30),
                child: _buildFeatureCard(context, feature),
              ))
          .toList(),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final features = AboutData.getAllFeatures();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features
          .map((feature) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _buildFeatureCard(context, feature),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    FeatureCard feature,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final padding = isMobile ? 20.0 : (screenWidth < 1200 ? 24.0 : 30.0);
    final iconPadding = isMobile ? 12.0 : 16.0;
    final iconSize = isMobile ? 32.0 : (screenWidth < 1200 ? 36.0 : 40.0);
    final titleSize = isMobile ? 18.0 : (screenWidth < 1200 ? 20.0 : 24.0);
    final descSize = isMobile ? 14.0 : 16.0;
    
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with background
          Container(
            padding: EdgeInsets.all(iconPadding),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.primaryLight.withOpacity(0.1)
                  : AppColors.primaryDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature.icon,
              size: iconSize,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.primaryLight
                  : AppColors.primaryDark,
            ),
          ).animate().scale(
                delay: feature.delay.ms,
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),
          SizedBox(height: isMobile ? 16 : 24),
          // Title - RESPONSIVE
          Text(
            feature.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: titleSize,
                ),
          ).animate().fadeIn(
                delay: (feature.delay + 200).ms,
                duration: 600.ms,
              ),
          SizedBox(height: isMobile ? 8 : 16),
          // Description - RESPONSIVE
          Text(
            feature.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: descSize,
                  height: 1.6,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withOpacity(0.7),
                ),
          ).animate().fadeIn(
                delay: (feature.delay + 400).ms,
                duration: 600.ms,
              ),
        ],
      ),
    ).animate().fadeIn(
          delay: feature.delay.ms,
          duration: 600.ms,
        ).slide(
          begin: const Offset(0, 0.2),
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }
}