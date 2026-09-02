import 'package:flutter/material.dart';

/// Stats bar showing total count, featured count, and average rating.
///
/// Renders as a row of stat chips with icons and values.
class TestimonialStatsBar extends StatelessWidget {
  final int totalCount;
  final int featuredCount;
  final double averageRating;

  const TestimonialStatsBar({
    super.key,
    required this.totalCount,
    required this.featuredCount,
    required this.averageRating,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _StatChip(
          icon: Icons.format_quote_rounded,
          label: 'Total',
          value: totalCount.toString(),
          color: theme.primaryColor,
          theme: theme,
        ),
        _StatChip(
          icon: Icons.star_rounded,
          label: 'Featured',
          value: featuredCount.toString(),
          color: Colors.amber,
          theme: theme,
        ),
        _StatChip(
          icon: Icons.trending_up_rounded,
          label: 'Avg Rating',
          value: averageRating > 0 ? averageRating.toStringAsFixed(1) : '—',
          color: Colors.green,
          theme: theme,
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ThemeData theme;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }
}
