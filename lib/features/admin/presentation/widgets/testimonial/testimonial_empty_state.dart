import 'package:flutter/material.dart';

/// Empty state widget shown when no testimonials exist.
///
/// Displays an illustration icon, message text, and a CTA button
/// to add the first testimonial.
class TestimonialEmptyState extends StatelessWidget {
  final VoidCallback onAddFirst;

  const TestimonialEmptyState({
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
                color: theme.primaryColor.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.format_quote_rounded,
                size: 56,
                color: theme.primaryColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'No Testimonials Yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add your first testimonial to showcase\nclient feedback on your portfolio.',
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
              label: const Text('Add First Testimonial'),
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
