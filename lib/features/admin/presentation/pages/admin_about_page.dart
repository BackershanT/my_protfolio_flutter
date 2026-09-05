import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/models/about_feature_model.dart';
import 'package:my_protfolio/features/admin/data/providers/about_feature_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/about/about_feature_form_dialog.dart';

class AdminAboutPage extends StatefulWidget {
  const AdminAboutPage({super.key});

  @override
  State<AdminAboutPage> createState() => _AdminAboutPageState();
}

class _AdminAboutPageState extends State<AdminAboutPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AboutFeatureProvider>().loadFeatures();
    });
  }

  Future<void> _handleCreate() async {
    final result = await AboutFeatureFormDialog.show(context);
    if (result != null && mounted) {
      final success = await context.read<AboutFeatureProvider>().addFeature(result);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Feature card created!' : 'Failed to create card'),
          ),
        );
      }
    }
  }

  Future<void> _handleEdit(AboutFeatureModel feature) async {
    final result = await AboutFeatureFormDialog.show(context, feature: feature);
    if (result != null && mounted) {
      final success =
          await context.read<AboutFeatureProvider>().updateFeature(feature.id, result);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Feature card updated!' : 'Failed to update card'),
          ),
        );
      }
    }
  }

  Future<void> _handleDelete(AboutFeatureModel feature) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Feature Card'),
        content: Text('Are you sure you want to delete "${feature.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await context.read<AboutFeatureProvider>().deleteFeature(feature.id);
      messenger.showSnackBar(
        SnackBar(
          content: Text(success ? 'Feature card deleted!' : 'Failed to delete card'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<AboutFeatureProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About Me Section Management',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage the core specialization cards displayed in your About Me portfolio section.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: _handleCreate,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Feature Card'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Main Content Area
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.errorMessage != null
                          ? _buildErrorView(provider, theme)
                          : provider.features.isEmpty
                              ? _buildEmptyView(theme)
                              : _buildFeatureList(provider, theme),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorView(AboutFeatureProvider provider, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
          const SizedBox(height: 12),
          Text(provider.errorMessage ?? 'Failed to load feature cards'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => provider.loadFeatures(),
            child: const Text('Retry'),
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
          Icon(Icons.info_outline, size: 64, color: theme.disabledColor),
          const SizedBox(height: 16),
          Text(
            'No About Me feature cards found',
            style: theme.textTheme.titleMedium?.copyWith(color: theme.disabledColor),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _handleCreate,
            icon: const Icon(Icons.add),
            label: const Text('Create First Card'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList(AboutFeatureProvider provider, ThemeData theme) {
    final list = provider.features;

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Order badge & Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item.iconData,
                    size: 28,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.hintColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Order #${item.sortOrder}',
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.hintColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Actions
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'Edit Card',
                      onPressed: () => _handleEdit(item),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      tooltip: 'Delete Card',
                      onPressed: () => _handleDelete(item),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
