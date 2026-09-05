class TranslationModel {
  final String key;
  final String en;
  final String ar;
  final String category;
  final DateTime updatedAt;

  TranslationModel({
    required this.key,
    required this.en,
    required this.ar,
    this.category = 'general',
    required this.updatedAt,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      key: json['key'] as String? ?? '',
      en: json['en'] as String? ?? '',
      ar: json['ar'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'en': en,
      'ar': ar,
      'category': category,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  TranslationModel copyWith({
    String? key,
    String? en,
    String? ar,
    String? category,
    DateTime? updatedAt,
  }) {
    return TranslationModel(
      key: key ?? this.key,
      en: en ?? this.en,
      ar: ar ?? this.ar,
      category: category ?? this.category,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
