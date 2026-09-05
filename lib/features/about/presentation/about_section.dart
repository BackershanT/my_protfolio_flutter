import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/providers/about_feature_provider.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/responsive.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';
import 'package:my_protfolio/core/presentation/widgets/section_title.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AboutFeatureProvider>().loadFeatures();
    });
  }

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
          Consumer<AboutFeatureProvider>(
            builder: (context, provider, child) {
              final features = _getDisplayFeatures(provider);

              return Responsive(
                mobile: _buildMobileLayout(context, features),
                tablet: _buildTabletLayout(context, features),
                desktop: _buildDesktopLayout(context, features),
              );
            },
          ),
        ],
      ),
    );
  }

  List<_FeatureDisplayItem> _getDisplayFeatures(AboutFeatureProvider provider) {
    int index = 0;
    return provider.features.map((f) {
      index++;
      return _FeatureDisplayItem(
        title: f.title,
        description: f.description,
        icon: f.iconData,
        delay: index * 200,
      );
    }).toList();
  }

  Widget _buildMobileLayout(BuildContext context, List<_FeatureDisplayItem> features) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: features
          .map((feature) => Padding(
                padding: EdgeInsets.only(bottom: screenWidth < 600 ? 20 : 30),
                child: _buildFeatureCard(context, feature),
              ))
          .toList(),
    );
  }

  Widget _buildTabletLayout(BuildContext context, List<_FeatureDisplayItem> features) {
    if (features.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _buildFeatureCard(context, features[0]),
              ),
            ),
            if (features.length > 1)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildFeatureCard(context, features[1]),
                ),
              ),
          ],
        ),
        if (features.length > 2)
          ...features.skip(2).map(
                (f) => Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: _buildFeatureCard(context, f),
                ),
              ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, List<_FeatureDisplayItem> features) {
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
    _FeatureDisplayItem feature,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final padding = isMobile ? 20.0 : (screenWidth < 1200 ? 24.0 : 30.0);
    final iconPadding = isMobile ? 12.0 : 16.0;
    final iconSize = isMobile ? 32.0 : (screenWidth < 1200 ? 36.0 : 40.0);
    final titleSize = isMobile ? 18.0 : (screenWidth < 1200 ? 20.0 : 24.0);
    final descSize = isMobile ? 14.0 : 16.0;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;

    final cardWidget = Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: isDark ? 0.08 : 0.04),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with background
          Container(
            padding: EdgeInsets.all(iconPadding),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primaryLight.withValues(alpha: 0.1)
                  : AppColors.primaryDark.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature.icon,
              size: iconSize,
              color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
            ),
          ).animate().scale(
                delay: feature.delay.ms,
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),
          SizedBox(height: isMobile ? 16 : 24),
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
          Text(
            feature.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: descSize,
                  height: 1.6,
                  color: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.color
                      ?.withValues(alpha: 0.7),
                ),
          ).animate().fadeIn(
                delay: (feature.delay + 400).ms,
                duration: 600.ms,
              ),
        ],
      ),
    );

    return TiltCard(
      maxTilt: isMobile ? 0 : 12,
      scale: isMobile ? 1.0 : 1.03,
      glareOpacity: 0.1,
      child: cardWidget,
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

class _FeatureDisplayItem {
  final String title;
  final String description;
  final IconData icon;
  final int delay;

  _FeatureDisplayItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.delay,
  });
}