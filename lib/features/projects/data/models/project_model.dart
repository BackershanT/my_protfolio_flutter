import 'package:flutter/services.dart' show rootBundle;

enum ProjectType { mobile, website, fullstack, flutter, react, nextjs }

class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final List<String> screenshots;
  final String? readmeContent;
  final String? readmeFilePath; // New field for README file path
  final String? demoUrl;
  final String? codeUrl;
  final List<ProjectType> types;
  final List<String> typeNames; // Formatted type names like 'Website', 'Mobile', 'Full Stack', 'Flutter', 'React', 'Next.js'
  final bool isFullStack; // Field to explicitly mark Full Stack projects
  final DateTime? createdAt;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.screenshots = const [],
    this.readmeContent,
    this.readmeFilePath,
    this.demoUrl,
    this.codeUrl,
    this.types = const [ProjectType.mobile],
    this.typeNames = const [],
    this.isFullStack = false,
    this.createdAt,
  });

  List<String> get resolvedTypeNames => typeNames.isNotEmpty
      ? typeNames
      : types.map((t) {
          switch (t) {
            case ProjectType.mobile:
              return 'Mobile';
            case ProjectType.website:
              return 'Website';
            case ProjectType.fullstack:
              return 'Full Stack';
            case ProjectType.flutter:
              return 'Flutter';
            case ProjectType.react:
              return 'React';
            case ProjectType.nextjs:
              return 'Next.js';
          }
        }).toList();

  // Method to load README content from file
  Future<String?> loadReadmeContent() async {
    if (readmeFilePath != null) {
      try {
        return await rootBundle.loadString(readmeFilePath!);
      } catch (e) {
        // Return null if file cannot be loaded
        return null;
      }
    }
    return readmeContent;
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    List<String> rawTypes = [];
    if (json['types'] != null && json['types'] is List) {
      rawTypes = (json['types'] as List).map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList();
    } else if (json['type'] != null) {
      rawTypes = [json['type'].toString().trim()];
    } else if (json['project_type'] != null) {
      rawTypes = [json['project_type'].toString().trim()];
    }

    List<ProjectType> projectTypes = rawTypes.map((typeStr) {
      final s = typeStr.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
      if (s.contains('mobile')) return ProjectType.mobile;
      if (s.contains('web')) return ProjectType.website;
      if (s.contains('fullstack')) return ProjectType.fullstack;
      if (s.contains('flutter')) return ProjectType.flutter;
      if (s.contains('react')) return ProjectType.react;
      if (s.contains('next')) return ProjectType.nextjs;
      return ProjectType.website;
    }).toSet().toList();

    if (projectTypes.isEmpty) {
      projectTypes = [ProjectType.mobile];
    }
    
    final isFullStackVal = json['isFullStack'] as bool? ??
        rawTypes.any((t) => t.toLowerCase().replaceAll(' ', '').contains('fullstack'));

    return Project(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? json['image_url'] as String? ?? '',
      technologies: json['technologies'] != null ? List<String>.from(json['technologies'] as List) : [],
      screenshots: json['screenshots'] != null
          ? List<String>.from(json['screenshots'] as List)
          : [],
      readmeContent: json['readmeContent'] as String? ?? json['read_me'] as String?,
      readmeFilePath: json['readmeFilePath'] as String?,
      demoUrl: json['demoUrl'] as String? ?? json['preview_url'] as String?,
      codeUrl: json['codeUrl'] as String? ?? json['github_url'] as String?,
      types: projectTypes,
      typeNames: rawTypes,
      isFullStack: isFullStackVal,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'screenshots': screenshots,
      'readmeContent': readmeContent,
      'readmeFilePath': readmeFilePath,
      'demoUrl': demoUrl,
      'codeUrl': codeUrl,
      'types': typeNames.isNotEmpty ? typeNames : types.map((e) => e.name).toList(),
      'typeNames': typeNames,
      'isFullStack': isFullStack,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
