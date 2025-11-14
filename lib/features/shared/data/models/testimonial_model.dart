class Testimonial {
  final String id;
  final String name;
  final String role;
  final String company;
  final String content;
  final String avatarUrl;

  Testimonial({
    required this.id,
    required this.name,
    required this.role,
    required this.company,
    required this.content,
    required this.avatarUrl,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      company: json['company'] as String,
      content: json['content'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'company': company,
      'content': content,
      'avatarUrl': avatarUrl,
    };
  }
}
