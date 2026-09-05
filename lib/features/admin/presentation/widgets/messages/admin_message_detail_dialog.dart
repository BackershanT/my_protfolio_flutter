import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_protfolio/features/admin/data/models/contact_message_model.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_contact_provider.dart';

/// Modal dialog showing complete contact message details with quick actions.
class AdminMessageDetailDialog extends StatelessWidget {
  final ContactMessageModel message;
  final AdminContactProvider provider;

  const AdminMessageDetailDialog({
    super.key,
    required this.message,
    required this.provider,
  });

  static void show(
    BuildContext context, {
    required ContactMessageModel message,
    required AdminContactProvider provider,
  }) {
    if (!message.isRead) {
      provider.markAsRead(message.id, true);
    }

    showDialog(
      context: context,
      builder: (ctx) => AdminMessageDetailDialog(
        message: message,
        provider: provider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: screenSize.width < 650 ? screenSize.width * 0.9 : 600,
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: screenSize.height * 0.85,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Modal Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2),
                            child: Text(
                              message.name.isNotEmpty ? message.name[0].toUpperCase() : '?',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.name,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  message.email,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),

                // Date info
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: theme.hintColor),
                    const SizedBox(width: 6),
                    Text(
                      'Received on: ${_formatFullDate(message.createdAt)}',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Message Body Container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.grey.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.5),
                    ),
                  ),
                  child: SelectableText(
                    message.message,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                ),

                const SizedBox(height: 24),

                // Actions Wrap
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: message.email));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email copied to clipboard!')),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('Copy Email'),
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => _confirmDelete(context),
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
                          label: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _replyToEmail(context, message.email),
                          icon: const Icon(Icons.reply, size: 18),
                          label: const Text('Reply via Email'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _replyToEmail(BuildContext context, String email) async {
    final Uri mailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Re: Inquiring via Portfolio',
      },
    );
    try {
      if (await canLaunchUrl(mailUri)) {
        await launchUrl(mailUri);
      } else {
        await Clipboard.setData(ClipboardData(text: email));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch mail app. Email ($email) copied to clipboard!')),
          );
        }
      }
    } catch (_) {
      await Clipboard.setData(ClipboardData(text: email));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email ($email) copied to clipboard!')),
        );
      }
    }
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
              Navigator.of(ctx).pop(); // Close confirm dialog
              Navigator.of(context).pop(); // Close detail modal
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

  String _formatFullDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
