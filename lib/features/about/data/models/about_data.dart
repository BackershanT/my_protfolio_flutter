import 'package:flutter/material.dart';

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
  static const features = [
    FeatureCard(
      icon: Icons.phone_android,
      title: 'Flutter Developer',
      description:
          'Building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase with Flutter.',
      delay: 200,
    ),
    FeatureCard(
      icon: Icons.code,
      title: 'React Developer',
      description:
          'Creating dynamic and responsive web applications using React, with expertise in modern frontend frameworks and libraries.',
      delay: 400,
    ),
    FeatureCard(
      icon: Icons.palette,
      title: 'UI/UX Focus',
      description:
          'Passionate about creating intuitive, pixel-perfect interfaces with attention to detail, smooth animations, and excellent user experience.',
      delay: 600,
    ),
  ];

  static List<FeatureCard> getAllFeatures() => features;
}
