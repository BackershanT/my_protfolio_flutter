class AdminBlogModel {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String date;
  final String time;

  const AdminBlogModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.date,
    required this.time,
  });

  factory AdminBlogModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedTechnologies = [];
    if (json['technologies'] != null) {
      if (json['technologies'] is List) {
        parsedTechnologies = (json['technologies'] as List)
            .map((e) => e.toString().trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
    }

    return AdminBlogModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      technologies: parsedTechnologies,
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title.trim(),
      'description': description.trim(),
      'image_url': imageUrl.trim(),
      'technologies': technologies,
      'date': date.isNotEmpty ? date : null,
      'time': time.isNotEmpty ? time : null,
    };
  }

  AdminBlogModel copyWith({
    String? title,
    String? description,
    String? imageUrl,
    List<String>? technologies,
    String? date,
    String? time,
  }) {
    return AdminBlogModel(
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      technologies: technologies ?? this.technologies,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
