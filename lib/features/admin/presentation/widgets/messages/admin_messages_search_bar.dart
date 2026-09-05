import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_contact_provider.dart';

/// Search input and filter segmented button widget for Admin Messages page.
class AdminMessagesSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final AdminContactProvider provider;

  const AdminMessagesSearchBar({
    super.key,
    required this.searchController,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 650;

        final searchField = TextField(
          controller: searchController,
          onChanged: (val) => provider.setSearchQuery(val),
          decoration: InputDecoration(
            hintText: 'Search by sender name, email, or content...',
            prefixIcon: const Icon(Icons.search, size: 20),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 18),
                    onPressed: () {
                      searchController.clear();
                      provider.setSearchQuery('');
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.dividerColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white12 : Colors.black12,
              ),
            ),
            filled: true,
            fillColor: isDark
                ? Colors.white.withValues(alpha: 0.04)
                : Colors.grey.withValues(alpha: 0.05),
          ),
        );

        final filterSegmented = SegmentedButton<MessageFilter>(
          segments: const [
            ButtonSegment(
              value: MessageFilter.all,
              label: Text('All'),
              icon: Icon(Icons.mark_email_unread_outlined, size: 16),
            ),
            ButtonSegment(
              value: MessageFilter.unread,
              label: Text('Unread'),
              icon: Icon(Icons.mark_email_unread, size: 16),
            ),
            ButtonSegment(
              value: MessageFilter.read,
              label: Text('Read'),
              icon: Icon(Icons.drafts, size: 16),
            ),
          ],
          selected: {provider.selectedFilter},
          onSelectionChanged: (set) {
            if (set.isNotEmpty) {
              provider.setFilter(set.first);
            }
          },
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              searchField,
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: filterSegmented,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: searchField),
            const SizedBox(width: 16),
            filterSegmented,
          ],
        );
      },
    );
  }
}
