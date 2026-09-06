import 'package:flutter/material.dart';
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
        name: 'Fastline',
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

  // static TechnologySection get mernSection => TechnologySection(
  //   name: AppTexts.techMernName,
  //   subtitle: AppTexts.techMernSubtitle,
  //   headline: AppTexts.techMernHeadline,
  //   description: AppTexts.techMernDescription,
  //   centerAsset: AppAssets.skillsMern,
  //   technologies: const [
  //     TechnologyModel(
  //       assetPath: AppAssets.skillsMongoDb,
  //       name: 'MongoDB',
  //       color: Color(0xFF47A248),
  //     ),
  //     TechnologyModel(
  //       assetPath: AppAssets.skillsExpressJs,
  //       name: 'Express.js',
  //       color: Colors.black,
  //     ),
  //     TechnologyModel(
  //       assetPath: AppAssets.skillsReact,
  //       name: 'React',
  //       color: Color(0xFF61DAFB),
  //     ),
  //     TechnologyModel(
  //       assetPath: AppAssets.skillsNodejs,
  //       name: 'Node.js',
  //       color: Color(0xFF339933),
  //     ),
  //     TechnologyModel(
  //       assetPath: AppAssets.skillsAws,
  //       name: 'AWS',
  //       color: Color(0xFFFF6B35),
  //     ),
  //   ],
  // );

  static List<TechnologySection> getAllSections() {
    return [flutterSection, reactSection, 
    // mernSection
    ];
  }
}
