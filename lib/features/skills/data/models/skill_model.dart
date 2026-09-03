import 'package:my_protfolio/core/constants/app_assets.dart';

class SkillModel {
  final int? id;
  final String name;
  final String image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SkillModel({
    this.id,
    required this.name,
    required this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      image: json['image'] as String,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'image': image,
      if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt?.toIso8601String(),
    };
  }

  SkillModel copyWith({
    int? id,
    String? name,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SkillModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SkillData {
  static const skills = [
    SkillModel(
      image: AppAssets.skillsFlutter,
      name: 'Flutter',
    ),
    SkillModel(
      image: AppAssets.skillsReact,
      name: 'React',
    ),
    SkillModel(
      image: AppAssets.skillsJavascript,
      name: 'JavaScript',
    ),
    SkillModel(
      image: AppAssets.skillsFirebase,
      name: 'Firebase',
    ),
    SkillModel(
      image: AppAssets.skillsBloc,
      name: 'BLoC',
    ),
    SkillModel(
      image: AppAssets.skillsRedux,
      name: 'Redux',
    ),
    SkillModel(
      image: AppAssets.skillsNextjs,
      name: 'Next.js',
    ),
    SkillModel(
      image: AppAssets.skillsSocket,
      name: 'Socket.IO',
    ),
    SkillModel(
      image: AppAssets.skillsSupabase,
      name: 'Supabase',
    ),
    SkillModel(
      image: AppAssets.skillsNeon,
      name: 'Neon',
    ),
    SkillModel(
      image: AppAssets.skillsHtml,
      name: 'Html',
    ),
    SkillModel(
      image: AppAssets.skillsCss,
      name: 'Css',
    ),
    SkillModel(
      image: AppAssets.skillsFigma,
      name: 'Figma',
    ),
    SkillModel(
      image: AppAssets.skillsXd,
      name: 'Xd',
    ),
  ];

  static List<SkillModel> getAllSkills() => skills;
}
