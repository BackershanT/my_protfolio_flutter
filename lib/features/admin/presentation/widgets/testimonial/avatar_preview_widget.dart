import 'package:flutter/material.dart';

/// Circular avatar preview with live URL loading.
///
/// Shows the avatar from a URL, falling back to initials when the URL
/// is empty or the image fails to load.
class AvatarPreviewWidget extends StatelessWidget {
  final String? avatarUrl;
  final String name;
  final double radius;

  const AvatarPreviewWidget({
    super.key,
    this.avatarUrl,
    required this.name,
    this.radius = 40,
  });

  String get _initials {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasUrl = avatarUrl != null && avatarUrl!.trim().isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: theme.primaryColor.withOpacity(0.15),
        backgroundImage: hasUrl ? NetworkImage(avatarUrl!) : null,
        onBackgroundImageError: hasUrl ? (_, __) {} : null,
        child: !hasUrl
            ? Text(
                _initials,
                style: TextStyle(
                  fontSize: radius * 0.7,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              )
            : null,
      ),
    );
  }
}
