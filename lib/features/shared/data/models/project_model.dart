import 'package:flutter/services.dart' show rootBundle;

enum ProjectType { mobile, website }

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
  final ProjectType type;
  final bool isFullStack; // New field to explicitly mark Full Stack projects

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.screenshots = const [],
    this.readmeContent,
    this.readmeFilePath, // New parameter
    this.demoUrl,
    this.codeUrl,
    this.type = ProjectType.mobile,
    this.isFullStack = false, // Default to false
  });

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
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      screenshots: json['screenshots'] != null
          ? List<String>.from(json['screenshots'] as List)
          : [],
      readmeContent: json['readmeContent'] as String?,
      readmeFilePath: json['readmeFilePath'] as String?, // New field
      demoUrl: json['demoUrl'] as String?,
      codeUrl: json['codeUrl'] as String?,
      type: json['type'] != null
          ? ProjectType.values.firstWhere(
              (e) => e.name == json['type'],
              orElse: () => ProjectType.mobile,
            )
          : ProjectType.mobile,
      isFullStack: json['isFullStack'] as bool? ?? false,
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
      'readmeFilePath': readmeFilePath, // New field
      'demoUrl': demoUrl,
      'codeUrl': codeUrl,
      'type': type.name,
      'isFullStack': isFullStack,
    };
  }
}
