import 'package:flutter/material.dart';

/// Styled toggle switch for the "Featured" flag.
/// 
/// Shows an animated switch with a descriptive label and icon.
class FeaturedToggleWidget extends StatelessWidget {
  final bool isFeatured;
  final ValueChanged<bool> onChanged;

  const FeaturedToggleWidget({
    super.key,
    required this.isFeatured,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isFeatured
            ? theme.primaryColor.withOpacity(0.08)
            : theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFeatured
              ? theme.primaryColor.withOpacity(0.3)
              : theme.dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isFeatured ? Icons.star_rounded : Icons.star_outline_rounded,
              key: ValueKey(isFeatured),
              color: isFeatured ? Colors.amber : theme.hintColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Featured Testimonial',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isFeatured
                      ? 'Visible on the homepage'
                      : 'Not shown on homepage',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: isFeatured,
            onChanged: onChanged,
            activeColor: theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
