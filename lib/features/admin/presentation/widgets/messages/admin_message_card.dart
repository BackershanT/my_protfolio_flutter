import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/contact_message_model.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_contact_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/messages/admin_message_detail_dialog.dart';

/// Card widget displaying a summary of an incoming contact message in the inbox.
class AdminMessageCard extends StatelessWidget {
  final ContactMessageModel message;
  final AdminContactProvider provider;

  const AdminMessageCard({
    super.key,
    required this.message,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isUnread = !message.isRead;

    final avatarChar = message.name.trim().isNotEmpty
        ? message.name.trim()[0].toUpperCase()
        : '?';

    return Card(
      elevation: isUnread ? 2 : 0.5,
      color: isDark
          ? (isUnread ? Colors.white.withValues(alpha: 0.08) : Colors.white.withValues(alpha: 0.03))
          : (isUnread ? Colors.white : theme.cardColor.withValues(alpha: 0.7)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isUnread
              ? theme.colorScheme.primary.withValues(alpha: 0.4)
              : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
          width: isUnread ? 1.5 : 1.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => AdminMessageDetailDialog.show(
          context,
          message: message,
          provider: provider,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 22,
                backgroundColor: isUnread
                    ? theme.colorScheme.primary
                    : theme.disabledColor.withValues(alpha: 0.3),
                child: Text(
                  avatarChar,
                  style: TextStyle(
                    color: isUnread ? Colors.white : theme.textTheme.bodyMedium?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Info & snippet
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isUnread) ...[
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          _formatDate(message.createdAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message.email,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Action buttons
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      message.isRead ? Icons.mark_email_unread_outlined : Icons.drafts_outlined,
                      size: 20,
                      color: theme.hintColor,
                    ),
                    tooltip: message.isRead ? 'Mark as Unread' : 'Mark as Read',
                    onPressed: () => provider.markAsRead(message.id, !message.isRead),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                    tooltip: 'Delete message',
                    onPressed: () => _confirmDelete(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Message'),
        content: Text('Are you sure you want to delete the message from "${message.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.of(ctx).pop();
              final success = await provider.deleteMessage(message.id);
              messenger.showSnackBar(
                SnackBar(
                  content: Text(
                    success ? 'Message deleted successfully' : 'Failed to delete message',
                  ),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
