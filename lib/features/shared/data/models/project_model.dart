enum ProjectType { mobile, website }

class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final List<String> screenshots;
  final String? readmeContent;
  final String? demoUrl;
  final String? codeUrl;
  final ProjectType type;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.screenshots = const [],
    this.readmeContent,
    this.demoUrl,
    this.codeUrl,
    this.type = ProjectType.mobile,
  });

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
      demoUrl: json['demoUrl'] as String?,
      codeUrl: json['codeUrl'] as String?,
      type: json['type'] != null
          ? ProjectType.values.firstWhere(
              (e) => e.name == json['type'],
              orElse: () => ProjectType.mobile,
            )
          : ProjectType.mobile,
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
      'demoUrl': demoUrl,
      'codeUrl': codeUrl,
      'type': type.name,
    };
  }
}
