import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/providers/translation_provider.dart';

class TranslationFilterBar extends StatelessWidget {
  final TranslationProvider provider;
  final TextEditingController searchController;

  const TranslationFilterBar({
    super.key,
    required this.provider,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final categories = provider.categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input
        TextField(
          controller: searchController,
          onChanged: provider.setSearchQuery,
          decoration: InputDecoration(
            hintText: 'Search by key, English text, or Arabic text...',
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
            filled: true,
            fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Category Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((cat) {
              final isSelected = provider.selectedCategory.toLowerCase() == cat.toLowerCase();
              final displayName = cat == 'all'
                  ? 'All (${provider.translations.length})'
                  : '${cat[0].toUpperCase()}${cat.substring(1)}';

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(
                    displayName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black87),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: theme.colorScheme.primary,
                  checkmarkColor: Colors.white,
                  backgroundColor: isDark ? Colors.white10 : Colors.grey.shade200,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onSelected: (_) => provider.setSelectedCategory(cat),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
