import 'package:flutter/material.dart';

/// Empty state widget shown when no skills exist.
///
/// Displays an illustration icon, message text, and a CTA button
/// to add the first skill.
class SkillEmptyState extends StatelessWidget {
  final VoidCallback onAddFirst;

  const SkillEmptyState({
    super.key,
    required this.onAddFirst,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration container
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.code_rounded,
                size: 56,
                color: theme.primaryColor.withValues(alpha: 0.3),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'No Skills Yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add your first skill to showcase\nyour expertise on your portfolio.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onAddFirst,
              icon: const Icon(Icons.add_rounded, size: 20),
              label: const Text('Add First Skill'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
