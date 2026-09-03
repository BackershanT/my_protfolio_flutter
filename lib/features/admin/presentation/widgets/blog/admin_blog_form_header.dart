import 'package:flutter/material.dart';

/// Header widget for the blog post form dialog.
class AdminBlogFormHeader extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onClose;

  const AdminBlogFormHeader({
    super.key,
    required this.isEditing,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isEditing ? Icons.edit_note_rounded : Icons.post_add_rounded,
            color: theme.primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? 'Edit Blog Post' : 'Create New Blog Post',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isEditing
                    ? 'Update the article details and technologies.'
                    : 'Publish a new post to showcase on your portfolio.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close_rounded),
          splashRadius: 20,
          color: theme.hintColor,
        ),
      ],
    );
  }
}
