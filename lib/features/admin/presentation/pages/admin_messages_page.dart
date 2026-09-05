import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_contact_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/messages/admin_messages_header.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/messages/admin_messages_search_bar.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/messages/admin_message_card.dart';

/// Main page for managing incoming contact messages and inquiries in the admin panel.
class AdminMessagesPage extends StatefulWidget {
  const AdminMessagesPage({super.key});

  @override
  State<AdminMessagesPage> createState() => _AdminMessagesPageState();
}

class _AdminMessagesPageState extends State<AdminMessagesPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminContactProvider>().loadMessages();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<AdminContactProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header & Stats
                AdminMessagesHeader(provider: provider),
                const SizedBox(height: 20),

                // Search & Filter controls
                AdminMessagesSearchBar(
                  searchController: _searchController,
                  provider: provider,
                ),
                const SizedBox(height: 16),

                // Message List or State Views
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.errorMessage != null
                          ? _buildErrorView(provider, theme)
                          : provider.filteredMessages.isEmpty
                              ? _buildEmptyView(theme)
                              : _buildMessageList(provider),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageList(AdminContactProvider provider) {
    final list = provider.filteredMessages;

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = list[index];
        return AdminMessageCard(
          message: item,
          provider: provider,
        );
      },
    );
  }

  Widget _buildErrorView(AdminContactProvider provider, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
          const SizedBox(height: 12),
          Text(
            provider.errorMessage ?? 'An error occurred',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => provider.loadMessages(),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: theme.disabledColor),
          const SizedBox(height: 16),
          Text(
            'No messages found',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.disabledColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Messages sent through your Contact Us form will appear here.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }
}
