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
        iconData: Icons.layers_rounded,
        name: 'Provider',
        color: Color(0xFF5E5CE6),
      ),
      TechnologyModel(
        iconData: Icons.device_hub_rounded,
        name: 'Riverpod',
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
        iconData: Icons.palette,
        name: 'Material UI',
        color: Color(0xFF007FFF),
      ),
      TechnologyModel(
        iconData: Icons.code_rounded,
        name: 'TypeScript',
        color: Color(0xFF3178C6),
      ),
    ],
  );

  static List<TechnologySection> getAllSections() {
    return [flutterSection, reactSection];
  }
}
