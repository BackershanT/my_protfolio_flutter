class TestimonialModel {
  final int? id;
  final String name;
  final String role;
  final String? company;
  final String content;
  final String? avatarUrl;
  final int rating;
  final bool isFeatured;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TestimonialModel({
    this.id,
    required this.name,
    required this.role,
    this.company,
    required this.content,
    this.avatarUrl,
    this.rating = 5,
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    return TestimonialModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      company: json['company'] as String?,
      content: json['content'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      rating: json['rating'] as int? ?? 5,
      isFeatured: json['is_featured'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'company': company,
      'content': content,
      'avatarUrl': avatarUrl,
      'rating': rating,
      'is_featured': isFeatured,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  TestimonialModel copyWith({
    int? id,
    String? name,
    String? role,
    String? company,
    String? content,
    String? avatarUrl,
    int? rating,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TestimonialModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      company: company ?? this.company,
      content: content ?? this.content,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rating: rating ?? this.rating,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'TestimonialModel(id: $id, name: $name, role: $role, company: $company, rating: $rating, isFeatured: $isFeatured)';
  }
}
