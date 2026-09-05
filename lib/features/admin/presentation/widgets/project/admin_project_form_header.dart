import 'package:flutter/material.dart';

/// Header widget for the project form dialog.
class AdminProjectFormHeader extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onClose;

  const AdminProjectFormHeader({
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
            isEditing ? Icons.edit_note_rounded : Icons.create_new_folder_rounded,
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
                isEditing ? 'Edit Project' : 'Create New Project',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isEditing
                    ? 'Update project details, screenshots, and live demo links.'
                    : 'Showcase a new app, website, or library in your portfolio.',
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
