import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';

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
  final String centerAsset;
  final List<TechnologyModel> technologies;

  const TechnologySection({
    required this.name,
    required this.subtitle,
    required this.headline,
    required this.description,
    required this.centerAsset,
    required this.technologies,
  });
}

class TechnologyData {
  static const flutterSection = TechnologySection(
    name: 'Flutter',
    subtitle: 'Cross-Platform Development',
    headline: 'Flutter & Dart ecosystem mastery',
    description:
        'Building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Expert in Flutter widgets, state management (Provider, Riverpod, BLoC), animations, and Firebase integration.',
    centerAsset: AppAssets.skillsFlutter,
    technologies: [
      TechnologyModel(
        assetPath: AppAssets.skillsFirebase,
        name: 'Firebase',
        color: Color(0xFFFFCA28),
      ),
      TechnologyModel(
        assetPath: AppAssets.skillsBloc,
        name: 'BLoC',
        color: Color(0xFF0175C2),
      ),
      TechnologyModel(
        assetPath: AppAssets.skillsSocket,
        name: 'Socket.IO',
        color: Colors.black,
      ),
      TechnologyModel(
        assetPath: AppAssets.skillsHive,
        name: 'Hive',
        color: Color(0xFF5E5CE6),
      ),
      TechnologyModel(
        assetPath: AppAssets.skillsFastlane,
        name: 'Fastline',
        color: Color(0xFF00A6ED),
      ),
       TechnologyModel(
        assetPath: AppAssets.skillsFlame,
        name: 'Flame',
        color: Color(0xFF00A6ED),
      ),
    ],
  );

  static const reactSection = TechnologySection(
    name: 'React',
    subtitle: 'Modern Web Development',
    headline: 'React ecosystem expertise',
    description:
        'Creating dynamic and responsive web applications using React, with expertise in modern frontend frameworks and libraries. Proficient in React hooks, Redux state management, Next.js, and component-driven development.',
    centerAsset: AppAssets.skillsReact,
    technologies: [
      TechnologyModel(
        assetPath: AppAssets.skillsJavascript,
        name: 'JavaScript',
        color: Color(0xFFF7DF1E),
      ),
      TechnologyModel(
        assetPath: AppAssets.skillsNextjs,
        name: 'Next.js',
        color: Colors.black,
      ),
      TechnologyModel(
        assetPath: AppAssets.skillsRedux,
        name: 'Redux',
        color: Color(0xFF764ABC),
      ),
      TechnologyModel(
        assetPath: AppAssets.skillsVite,
        name: 'Vite',
        color: Color(0xFF007FFF),
      ),
      TechnologyModel(
        assetPath: AppAssets.skillsTailwind,
        name: 'Tailwind.css',
        color: Color(0xFF3178C6),
      ),
    ],
  );

  // static const mernSection = TechnologySection(
  //   name: 'MERN Stack',
  //   subtitle: 'Full-Stack JavaScript Development',
  //   headline: 'Complete MERN ecosystem proficiency',
  //   description:
  //       'Building scalable full-stack web applications using the MERN stack (MongoDB, Express.js, React, Node.js). Expertise in RESTful APIs, database design, server-side rendering, authentication, and modern JavaScript/TypeScript development practices.',
  //   centerAsset: AppAssets.skillsMern,
  //   technologies: [
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
  //       assetPath: AppAssets.skillsJavascript,
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
