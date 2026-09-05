import 'package:flutter/material.dart';

class AboutFeatureModel {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final int sortOrder;
  final DateTime? createdAt;

  AboutFeatureModel({
    required this.id,
    required this.title,
    required this.description,
    this.iconName = 'phone_android',
    this.sortOrder = 0,
    this.createdAt,
  });

  factory AboutFeatureModel.fromJson(Map<String, dynamic> json) {
    return AboutFeatureModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      iconName: json['icon_name'] as String? ?? 'phone_android',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'title': title,
      'description': description,
      'icon_name': iconName,
      'sort_order': sortOrder,
    };
  }

  AboutFeatureModel copyWith({
    String? id,
    String? title,
    String? description,
    String? iconName,
    int? sortOrder,
    DateTime? createdAt,
  }) {
    return AboutFeatureModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Maps string icon identifier to Material IconData
  IconData get iconData {
    return getIconByName(iconName);
  }

  static IconData getIconByName(String name) {
    switch (name.toLowerCase()) {
      case 'phone_android':
      case 'mobile':
      case 'flutter':
        return Icons.phone_android;
      case 'code':
      case 'developer':
        return Icons.code;
      case 'palette':
      case 'design':
      case 'uiux':
        return Icons.palette;
      case 'web':
      case 'browser':
      case 'language':
        return Icons.language;
      case 'terminal':
      case 'backend':
        return Icons.terminal;
      case 'layers':
      case 'architecture':
        return Icons.layers;
      case 'cloud':
      case 'server':
        return Icons.cloud;
      case 'api':
      case 'rest':
        return Icons.api;
      case 'storage':
      case 'database':
        return Icons.storage;
      case 'security':
      case 'auth':
        return Icons.security;
      case 'speed':
      case 'performance':
        return Icons.speed;
      case 'bug_report':
      case 'testing':
        return Icons.bug_report;
      case 'computer':
      case 'desktop':
        return Icons.computer;
      default:
        return Icons.star_rounded;
    }
  }

  static const List<Map<String, dynamic>> availableIcons = [
    {'name': 'phone_android', 'label': 'Mobile / Flutter', 'icon': Icons.phone_android},
    {'name': 'code', 'label': 'Code / Engineering', 'icon': Icons.code},
    {'name': 'palette', 'label': 'UI/UX & Design', 'icon': Icons.palette},
    {'name': 'web', 'label': 'Web Development', 'icon': Icons.language},
    {'name': 'terminal', 'label': 'Backend / Server', 'icon': Icons.terminal},
    {'name': 'layers', 'label': 'Architecture', 'icon': Icons.layers},
    {'name': 'cloud', 'label': 'Cloud & DevOps', 'icon': Icons.cloud},
    {'name': 'api', 'label': 'API & Microservices', 'icon': Icons.api},
    {'name': 'storage', 'label': 'Database & Storage', 'icon': Icons.storage},
    {'name': 'security', 'label': 'Security & Auth', 'icon': Icons.security},
    {'name': 'speed', 'label': 'Performance', 'icon': Icons.speed},
    {'name': 'computer', 'label': 'Desktop / Tech', 'icon': Icons.computer},
  ];
}
