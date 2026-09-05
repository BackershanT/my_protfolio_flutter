import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_contact_provider.dart';

/// Header widget for the Admin Messages page showing title, unread badges, and statistics.
class AdminMessagesHeader extends StatelessWidget {
  final AdminContactProvider provider;

  const AdminMessagesHeader({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 750;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runSpacing: 6,
                        children: [
                          Text(
                            'Messages & Inquiries',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (provider.unreadCount > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5)),
                              ),
                              child: Text(
                                '${provider.unreadCount} NEW',
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage incoming contact submissions from your portfolio website.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isCompact) ...[
                  const SizedBox(width: 16),
                  _buildStatRow(theme),
                ],
              ],
            ),
            if (isCompact) ...[
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildStatRow(theme),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildStatRow(ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatBadge(
          label: 'Total',
          value: provider.totalCount.toString(),
          color: theme.colorScheme.primary,
          theme: theme,
        ),
        const SizedBox(width: 8),
        _buildStatBadge(
          label: 'Unread',
          value: provider.unreadCount.toString(),
          color: Colors.orange,
          theme: theme,
        ),
        const SizedBox(width: 8),
        _buildStatBadge(
          label: 'Read',
          value: provider.readCount.toString(),
          color: Colors.green,
          theme: theme,
        ),
        const SizedBox(width: 12),
        IconButton.filledTonal(
          onPressed: () => provider.loadMessages(),
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh messages',
        ),
      ],
    );
  }

  Widget _buildStatBadge({
    required String label,
    required String value,
    required Color color,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: theme.hintColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
