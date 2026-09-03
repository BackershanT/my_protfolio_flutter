import 'package:flutter/material.dart';

class AdminBlogFormActions extends StatelessWidget {
  final bool isEditing;
  final bool isSubmitting;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const AdminBlogFormActions({
    super.key,
    required this.isEditing,
    this.isSubmitting = false,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isSubmitting ? null : onCancel,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: isSubmitting ? null : onSave,
            icon: isSubmitting
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.scaffoldBackgroundColor,
                    ),
                  )
                : Icon(
                    isEditing ? Icons.save_rounded : Icons.add_rounded,
                    size: 20,
                  ),
            label: Text(
              isSubmitting
                  ? 'Saving...'
                  : (isEditing ? 'Update Post' : 'Publish Post'),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
