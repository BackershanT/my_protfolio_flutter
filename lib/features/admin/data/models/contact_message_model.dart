class ContactMessageModel {
  final String id;
  final String name;
  final String email;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  ContactMessageModel({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    this.isRead = false,
    required this.createdAt,
  });

  factory ContactMessageModel.fromJson(Map<String, dynamic> json) {
    return ContactMessageModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? 'Anonymous',
      email: json['email'] as String? ?? 'No email',
      message: json['message'] as String? ?? '',
      isRead: json['is_read'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'message': message,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }

  ContactMessageModel copyWith({
    String? id,
    String? name,
    String? email,
    String? message,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return ContactMessageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
