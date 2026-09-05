import 'package:flutter/material.dart';

/// Stats bar displaying summary statistics for projects.
class AdminProjectStatsBar extends StatelessWidget {
  final int totalCount;
  final int companiesCount;
  final int technologiesCount;

  const AdminProjectStatsBar({
    super.key,
    required this.totalCount,
    required this.companiesCount,
    required this.technologiesCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        _StatChip(
          icon: Icons.work_outline_rounded,
          label: 'Total Projects',
          value: totalCount.toString(),
          color: theme.primaryColor,
          theme: theme,
        ),
        _StatChip(
          icon: Icons.business_rounded,
          label: 'Companies',
          value: companiesCount.toString(),
          color: Colors.orangeAccent,
          theme: theme,
        ),
        _StatChip(
          icon: Icons.code_rounded,
          label: 'Technologies',
          value: technologiesCount.toString(),
          color: Colors.cyan,
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
