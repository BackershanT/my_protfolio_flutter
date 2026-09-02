class Skill {
  final String id;
  final String name;
  final String iconAsset;
  final double level; // 0.0 to 1.0

  Skill({
    required this.id,
    required this.name,
    required this.iconAsset,
    required this.level,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] as String,
      name: json['name'] as String,
      iconAsset: json['iconAsset'] as String,
      level: (json['level'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconAsset': iconAsset,
      'level': level,
    };
  }
}