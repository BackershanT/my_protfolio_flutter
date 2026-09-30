import 'package:flutter/material.dart';
import 'package:my_protfolio/core/constants/app_assets.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';

class TechnologyModel {
  final String? assetPath;
  final IconData? iconData;
  final String name;
  final Color color;

  const TechnologyModel({
    this.assetPath,
    this.iconData,
    required this.name,
    required this.color,
  });
}

class TechnologySection {
  final String name;
  final String subtitle;
  final String headline;
  final String description;
  final String? centerAsset;
  final List<TechnologyModel> technologies;

  const TechnologySection({
    required this.name,
    required this.subtitle,
    required this.headline,
    required this.description,
    this.centerAsset,
    required this.technologies,
  });
}

class TechnologyData {
  static TechnologySection get flutterSection => TechnologySection(
    name: AppTexts.techFlutterName,
    subtitle: AppTexts.techFlutterSubtitle,
    headline: AppTexts.techFlutterHeadline,
    description: AppTexts.techFlutterDescription,
    centerAsset: AppAssets.favLogo,
    technologies: const [
      TechnologyModel(
        name: 'Firebase',
        color: Color(0xFFFFCA28),
      ),
      TechnologyModel(
        name: 'BLoC',
        color: Color(0xFF0175C2),
      ),
      TechnologyModel(
        name: 'Socket.IO',
        color: Colors.black,
      ),
      TechnologyModel(
        name: 'Hive',
        color: Color(0xFF5E5CE6),
      ),
      TechnologyModel(
        name: 'Fastlane',
        color: Color(0xFF00A6ED),
      ),
      TechnologyModel(
        name: 'Flame',
        color: Color(0xFF00A6ED),
      ),
    ],
  );

  static TechnologySection get reactSection => TechnologySection(
    name: AppTexts.techReactName,
    subtitle: AppTexts.techReactSubtitle,
    headline: AppTexts.techReactHeadline,
    description: AppTexts.techReactDescription,
    centerAsset: AppAssets.favLogo,
    technologies: const [
      TechnologyModel(
        name: 'JavaScript',
        color: Color(0xFFF7DF1E),
      ),
      TechnologyModel(
        name: 'Next.js',
        color: Colors.black,
      ),
      TechnologyModel(
        name: 'Redux',
        color: Color(0xFF764ABC),
      ),
      TechnologyModel(
        name: 'Vite',
        color: Color(0xFF007FFF),
      ),
      TechnologyModel(
        name: 'Tailwind.css',
        color: Color(0xFF3178C6),
      ),
    ],
  );

  static TechnologySection get mernSection => TechnologySection(
    name: AppTexts.techMernName,
    subtitle: AppTexts.techMernSubtitle,
    headline: AppTexts.techMernHeadline,
    description: AppTexts.techMernDescription,
    centerAsset: AppAssets.favLogo,
    technologies: const [
      TechnologyModel(
        name: 'Node.js',
        color: Color(0xFF339933),
      ),
      TechnologyModel(
        name: 'Express.js',
        color: Colors.black,
      ),
      TechnologyModel(
        name: 'MongoDB',
        color: Color(0xFF47A248),
      ),
      TechnologyModel(
        name: 'Supabase',
        color: Color(0xFF3ECF8E),
      ),
      TechnologyModel(
        name: 'React',
        color: Color(0xFF61DAFB),
      ),
    ],
  );

  static List<TechnologySection> getAllSections() {
    return [
      flutterSection,
      reactSection,
      mernSection,
    ];
  }
}
