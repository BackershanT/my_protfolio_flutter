import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/providers/translation_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/translations/translation_card.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/translations/translation_filter_bar.dart';

class AdminTranslationsPage extends StatefulWidget {
  const AdminTranslationsPage({super.key});

  @override
  State<AdminTranslationsPage> createState() => _AdminTranslationsPageState();
}

class _AdminTranslationsPageState extends State<AdminTranslationsPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TranslationProvider>();
      if (provider.translations.isEmpty) {
        provider.loadTranslations();
      }
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
    final provider = context.watch<TranslationProvider>();
    final items = provider.filteredTranslations;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Translations & Localization',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Manage dynamic English and Arabic translations synchronized with Supabase',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Reload Translations',
                  onPressed: provider.isLoading ? null : () => provider.loadTranslations(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search & Category Filter Bar
            TranslationFilterBar(
              provider: provider,
              searchController: _searchController,
            ),
            const SizedBox(height: 16),

            // Main Content Area
            Expanded(
              child: Builder(
                builder: (context) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
                          const SizedBox(height: 12),
                          Text(
                            provider.errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () => provider.loadTranslations(),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.translate, size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            provider.translations.isEmpty
                                ? 'No translations found in Supabase.'
                                : 'No translations match your search or filter.',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return TranslationCard(
                        item: items[index],
                        provider: provider,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
