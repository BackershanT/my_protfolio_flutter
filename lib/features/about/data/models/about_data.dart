import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';

class FeatureCard {
  final IconData icon;
  final String title;
  final String description;
  final int delay;

  const FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.delay,
  });
}

class AboutData {
  static List<FeatureCard> get features => [
    FeatureCard(
      icon: Icons.phone_android,
      title: AppTexts.flutterDevTitle,
      description: AppTexts.flutterDevDesc,
      delay: 200,
    ),
    FeatureCard(
      icon: Icons.code,
      title: AppTexts.reactDevTitle,
      description: AppTexts.reactDevDesc,
      delay: 400,
    ),
    FeatureCard(
      icon: Icons.palette,
      title: AppTexts.uiuxTitle,
      description: AppTexts.uiuxDesc,
      delay: 600,
    ),
  ];

  static List<FeatureCard> getAllFeatures() => features;
}
