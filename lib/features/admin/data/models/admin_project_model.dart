class AdminProjectModel {
  final String name;
  final String companyName;
  final String imageUrl;
  final String description;
  final List<String> technologies;
  final String readMe;
  final String githubUrl;
  final String previewUrl;
  final String appStoreUrl;
  final String playStoreUrl;
  final List<String> screenshots;
  final String videosUrl;
  final String projectType;
  final List<String> types;
  final DateTime? createdAt;

  const AdminProjectModel({
    required this.name,
    required this.companyName,
    required this.imageUrl,
    required this.description,
    required this.technologies,
    required this.readMe,
    required this.githubUrl,
    required this.previewUrl,
    required this.appStoreUrl,
    required this.playStoreUrl,
    required this.screenshots,
    required this.videosUrl,
    this.projectType = 'Website',
    this.types = const ['Website'],
    this.createdAt,
  });

  factory AdminProjectModel.fromJson(Map<String, dynamic> json) {
    List<String> parseList(dynamic val) {
      if (val is List) {
        return val.map((e) => e.toString().trim()).where((e) => e.isNotEmpty).toList();
      }
      return [];
    }

    final parsedTypes = parseList(json['types']);
    final parsedType = json['project_type'] as String? ?? (parsedTypes.isNotEmpty ? parsedTypes.first : 'Website');
    final resolvedTypes = parsedTypes.isNotEmpty ? parsedTypes : (parsedType.isNotEmpty ? [parsedType] : ['Website']);

    return AdminProjectModel(
      name: json['name'] as String? ?? '',
      companyName: json['company_name'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      technologies: parseList(json['technologies']),
      readMe: json['read_me'] as String? ?? '',
      githubUrl: json['github_url'] as String? ?? '',
      previewUrl: json['preview_url'] as String? ?? '',
      appStoreUrl: json['app_store_url'] as String? ?? '',
      playStoreUrl: json['play_store_url'] as String? ?? '',
      screenshots: parseList(json['screenshots']),
      videosUrl: json['videos_url'] as String? ?? '',
      projectType: parsedType,
      types: resolvedTypes,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.trim(),
      'company_name': companyName.trim(),
      'image_url': imageUrl.trim(),
      'description': description.trim(),
      'technologies': technologies,
      'read_me': readMe.trim(),
      'github_url': githubUrl.trim(),
      'preview_url': previewUrl.trim(),
      'app_store_url': appStoreUrl.trim(),
      'play_store_url': playStoreUrl.trim(),
      'screenshots': screenshots,
      'videos_url': videosUrl.trim(),
      'project_type': projectType.trim(),
      'types': types,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  AdminProjectModel copyWith({
    String? name,
    String? companyName,
    String? imageUrl,
    String? description,
    List<String>? technologies,
    String? readMe,
    String? githubUrl,
    String? previewUrl,
    String? appStoreUrl,
    String? playStoreUrl,
    List<String>? screenshots,
    String? videosUrl,
    String? projectType,
    List<String>? types,
    DateTime? createdAt,
  }) {
    return AdminProjectModel(
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      readMe: readMe ?? this.readMe,
      githubUrl: githubUrl ?? this.githubUrl,
      previewUrl: previewUrl ?? this.previewUrl,
      appStoreUrl: appStoreUrl ?? this.appStoreUrl,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      screenshots: screenshots ?? this.screenshots,
      videosUrl: videosUrl ?? this.videosUrl,
      projectType: projectType ?? this.projectType,
      types: types ?? this.types,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
