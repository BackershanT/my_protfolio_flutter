import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/data/models/project_model.dart';
import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';

class ProjectDesign {
  final Color bgColor;
  final Color textColor;
  final Color logoColor;
  final Color descColor;
  final List<BlobShape> blobs;

  const ProjectDesign({
    required this.bgColor,
    required this.textColor,
    required this.logoColor,
    required this.descColor,
    required this.blobs,
  });
}

class BlobShape {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const BlobShape({
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
  });
}

class ProjectData {
  static final projects = [
    Project(
      id: '1',
      title: 'YChat Admin',
      description: 'Admin App for YChat App',
      technologies: ['flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectYchat,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '2',
      title: 'YChat',
      description:
          ' YChat Application for messaging screen mirroring and sharing.',
      technologies: ['Flutter', 'Socket.io', 'flutter webrtc'],
      imageUrl: AppAssets.projectYchat,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '3',
      title: 'Yachii',
      description: 'Yachii - Company Website with React.',
      technologies: ['React', 'JavaScript', 'useState'],
      imageUrl: AppAssets.projectYachii,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '4',
      title: 'My Games',
      description:
          'My Games - A collection of games built with Flutter and the Flame game engine.',
      technologies: ['flutter', 'Flame', 'Forge 2D'],
      imageUrl: AppAssets.projectMyGame,
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '5',
      title: 'My Bus',
      description:
          'My Bus App - A bus tracking app with real-time location updates and route information.',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectMyBus,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '6',
      title: 'Calculator',
      description: 'Calculator App built with Flutter.',
      technologies: ['Flutter', 'stateManagement'],
      imageUrl: AppAssets.projectCalculator,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '7',
      title: 'Calendar',
      description: 'Calendar App built with Flutter.',
      technologies: ['Flutter', 'stateManagement'],
      imageUrl: AppAssets.projectCalender,
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '8',
      title: 'Mahathma Veliyancode',
      description: 'Mahathma Veliyancode - A website built with React',
      technologies: ['React', 'useState'],
      imageUrl: AppAssets.projectMahathma,
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '9',
      title: 'Leo Rigging Calculator',
      description: 'Leo Rigging Calculator - A calculator built with flutter.',
      technologies: ['React', 'useState'],
      imageUrl: AppAssets.projectRigCalculator,
      codeUrl: '',
      demoUrl: '',
    ),

    Project(
      id: '10',
      title: 'Leo Inspector',
      description:
          'Leo Inspector - App with inspecting the heavy Vehicles  and create certificate',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectInspector,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '11',
      title: 'Leo Inspector Admin',
      description:
          'Leo Inspector Admin  - App with inspecting the heavy Vehicles  and create certificate',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectInspector,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '12',
      title: 'Reachout',
      description:
          'Reachout - A social platform for connecting with people.with card creating functionality',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectReachout,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '13',
      title: 'Movie App',
      description: 'Movie App - A movie app with search functionality',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectMovieApp,
      codeUrl: '',
      demoUrl: '',
    ),
    Project(
      id: '14',
      title: 'Netflix Clone',
      description: 'Netflix Clone - A Netflix clone built with React',
      technologies: ['React', 'firebase', 'useState'],
      imageUrl: AppAssets.projectNetflix,
      codeUrl: '',
      demoUrl: '',
    ),
  ];

  static List<Project> getAllProjects() => projects;

  static List<ProjectDesign> getDesigns(bool isDark, bool isMobile) {
    return [
      // Design 1 - Brown/Coral theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFFCF6B6B).withValues(alpha: 0.7)
            : const Color(0xFFE88B8B).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF4A4A4A) : const Color(0xFF5A5A5A),
        blobs: [
          BlobShape(
            left: isMobile ? -150.0 : -100.0,
            top: isMobile ? -100.0 : -80.0,
            width: isMobile ? 350.0 : 450.0,
            height: isMobile ? 350.0 : 450.0,
            color: isDark
                ? const Color(0xFF4A3A3A).withValues(alpha: 0.4)
                : const Color(0xFF8B6B6B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(250),
              topRight: Radius.circular(180),
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(300),
            ),
          ),
          BlobShape(
            left: isMobile ? -120.0 : -80.0,
            bottom: isMobile ? -120.0 : -100.0,
            width: isMobile ? 320.0 : 400.0,
            height: isMobile ? 320.0 : 400.0,
            color: isDark
                ? const Color(0xFF5A4A4A).withValues(alpha: 0.3)
                : const Color(0xFF9B7B7B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(200),
              topRight: Radius.circular(280),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ],
      ),
      // Design 2 - Blue/Purple theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFF6B8BCF).withValues(alpha: 0.7)
            : const Color(0xFF8BA8E8).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF3A4A5A) : const Color(0xFF4A5A6A),
        blobs: [
          BlobShape(
            right: isMobile ? -140.0 : -90.0,
            top: isMobile ? -110.0 : -90.0,
            width: isMobile ? 340.0 : 440.0,
            height: isMobile ? 340.0 : 440.0,
            color: isDark
                ? const Color(0xFF3A4A5A).withValues(alpha: 0.4)
                : const Color(0xFF6B7B8B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(260),
              topRight: Radius.circular(190),
              bottomLeft: Radius.circular(210),
              bottomRight: Radius.circular(290),
            ),
          ),
          BlobShape(
            left: isMobile ? -110.0 : -70.0,
            bottom: isMobile ? -110.0 : -90.0,
            width: isMobile ? 310.0 : 390.0,
            height: isMobile ? 310.0 : 390.0,
            color: isDark
                ? const Color(0xFF4A5A6A).withValues(alpha: 0.3)
                : const Color(0xFF7B8B9B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(210),
              topRight: Radius.circular(270),
              bottomLeft: Radius.circular(230),
              bottomRight: Radius.circular(190),
            ),
          ),
        ],
      ),
      // Design 3 - Green/Teal theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFF6BCF8B).withValues(alpha: 0.7)
            : const Color(0xFF8BE8A8).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF3A5A4A) : const Color(0xFF4A6A5A),
        blobs: [
          BlobShape(
            left: isMobile ? -130.0 : -85.0,
            top: isMobile ? -105.0 : -85.0,
            width: isMobile ? 330.0 : 430.0,
            height: isMobile ? 330.0 : 430.0,
            color: isDark
                ? const Color(0xFF3A5A4A).withValues(alpha: 0.4)
                : const Color(0xFF6B8B7B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(240),
              topRight: Radius.circular(200),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(280),
            ),
          ),
          BlobShape(
            right: isMobile ? -115.0 : -75.0,
            bottom: isMobile ? -115.0 : -95.0,
            width: isMobile ? 315.0 : 395.0,
            height: isMobile ? 315.0 : 395.0,
            color: isDark
                ? const Color(0xFF4A6A5A).withValues(alpha: 0.3)
                : const Color(0xFF7B9B8B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(195),
              topRight: Radius.circular(265),
              bottomLeft: Radius.circular(225),
              bottomRight: Radius.circular(200),
            ),
          ),
        ],
      ),
      // Design 4 - Orange/Amber theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFFCF8B6B).withValues(alpha: 0.7)
            : const Color(0xFFE8A88B).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF5A4A3A) : const Color(0xFF6A5A4A),
        blobs: [
          BlobShape(
            right: isMobile ? -135.0 : -88.0,
            top: isMobile ? -108.0 : -88.0,
            width: isMobile ? 335.0 : 435.0,
            height: isMobile ? 335.0 : 435.0,
            color: isDark
                ? const Color(0xFF5A4A3A).withValues(alpha: 0.4)
                : const Color(0xFF8B7B6B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(255),
              topRight: Radius.circular(185),
              bottomLeft: Radius.circular(215),
              bottomRight: Radius.circular(295),
            ),
          ),
          BlobShape(
            left: isMobile ? -118.0 : -78.0,
            bottom: isMobile ? -112.0 : -92.0,
            width: isMobile ? 318.0 : 398.0,
            height: isMobile ? 318.0 : 398.0,
            color: isDark
                ? const Color(0xFF6A5A4A).withValues(alpha: 0.3)
                : const Color(0xFF9B8B7B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(205),
              topRight: Radius.circular(275),
              bottomLeft: Radius.circular(235),
              bottomRight: Radius.circular(185),
            ),
          ),
        ],
      ),
    ];
  }

  static Map<String, IconData> getTechIcons() {
    return {
      'Flutter': Icons.flutter_dash,
      'Dart': Icons.code,
      'React': Icons.web,
      'Firebase': Icons.cloud,
      'JavaScript': Icons.javascript,
      'TypeScript': Icons.code_rounded,
      'Node.js': Icons.dns_rounded,
      'MongoDB': Icons.storage_rounded,
      'Material UI': Icons.palette_outlined,
      'Redux': Icons.settings_suggest_rounded,
      'Stripe': Icons.payment_rounded,
      'Provider': Icons.layers_rounded,
      'Riverpod': Icons.device_hub_rounded,
      'Chart.js': Icons.bar_chart_rounded,
      'OpenWeather API': Icons.wb_sunny_outlined,
      'Google Maps': Icons.map_outlined,
      'Health API': Icons.favorite_outline,
    };
  }
}
