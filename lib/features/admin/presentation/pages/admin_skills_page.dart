import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';
import 'package:my_protfolio/features/admin/data/providers/skill_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/skill/skill_form_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/skill/skill_delete_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/skill/skill_empty_state.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/skill/admin_skill_card.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/custom_snackbar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AdminSkillsPage extends StatefulWidget {
  const AdminSkillsPage({super.key});

  @override
  State<AdminSkillsPage> createState() => _AdminSkillsPageState();
}

class _AdminSkillsPageState extends State<AdminSkillsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SkillProvider>().loadSkills();
    });
  }

  Future<void> _handleAdd() async {
    final result = await SkillFormDialog.show(context);
    if (result == null || !mounted) return;

    final provider = context.read<SkillProvider>();
    final success = await provider.addSkill(result);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Skill added successfully!',
        type: SnackbarType.success,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to add skill',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleEdit(SkillModel skill) async {
    final result = await SkillFormDialog.show(
      context,
      skill: skill,
    );
    if (result == null || !mounted) return;

    final provider = context.read<SkillProvider>();
    final success = await provider.updateSkill(result);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Skill updated successfully!',
        type: SnackbarType.success,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to update skill',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleToggleActive(SkillModel skill, bool isActive) async {
    if (skill.id == null) return;
    final provider = context.read<SkillProvider>();
    final success = await provider.toggleSkillActive(skill.id!, isActive);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: isActive
            ? '${skill.name} activated & visible on website!'
            : '${skill.name} deactivated & hidden from website',
        type: SnackbarType.info,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to update status',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleDelete(SkillModel skill) async {
    if (skill.id == null) return;

    await SkillDeleteDialog.show(
      context,
      skillName: skill.name,
      onConfirm: () async {
        final provider = context.read<SkillProvider>();
        final success = await provider.deleteSkill(skill.id!);

        if (!mounted) return;
        if (success) {
          CustomSnackbar.show(
            context,
            message: 'Skill deleted successfully!',
            type: SnackbarType.success,
          );
        } else {
          CustomSnackbar.show(
            context,
            message: provider.error ?? 'Failed to delete skill',
            type: SnackbarType.error,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SkillProvider>(
      builder: (context, provider, _) {
        return RefreshIndicator(
          onRefresh: provider.loadSkills,
          child: _buildContent(provider),
        );
      },
    );
  }

  Widget _buildContent(SkillProvider provider) {
    final skills = provider.skills;
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage Skills',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Control which skills appear on the website and toggle active status',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _handleAdd,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Skill'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Status Filter Chips
                Wrap(
                  spacing: 8,
                  children: [
                    _buildFilterChip(
                      label: 'All (${provider.totalCount})',
                      filterValue: 'all',
                      currentFilter: provider.statusFilter,
                      onSelected: () => provider.setStatusFilter('all'),
                    ),
                    _buildFilterChip(
                      label: 'Active (${provider.activeCount})',
                      filterValue: 'active',
                      currentFilter: provider.statusFilter,
                      onSelected: () => provider.setStatusFilter('active'),
                      color: Colors.green,
                    ),
                    _buildFilterChip(
                      label: 'Inactive (${provider.inactiveCount})',
                      filterValue: 'inactive',
                      currentFilter: provider.statusFilter,
                      onSelected: () => provider.setStatusFilter('inactive'),
                      color: Colors.amber,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Error banner
        if (provider.error != null)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(14),
              color: Colors.red.withValues(alpha: 0.1),
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),

        // Skeleton or empty or grid
        if (provider.isLoading && skills.isEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.88,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(color: Colors.grey.withValues(alpha: 0.1)),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 1200.ms, color: Colors.white24);
                },
                childCount: 8,
              ),
            ),
          )
        else if (!provider.isLoading && skills.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: SkillEmptyState(onAddFirst: _handleAdd),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.88,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final skill = skills[index];
                  return AdminSkillCard(
                    skill: skill,
                    provider: provider,
                    onEdit: () => _handleEdit(skill),
                    onDelete: () => _handleDelete(skill),
                    onToggleActive: (val) => _handleToggleActive(skill, val),
                  );
                },
                childCount: skills.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String filterValue,
    required String currentFilter,
    required VoidCallback onSelected,
    Color? color,
  }) {
    final isSelected = currentFilter == filterValue;
    final theme = Theme.of(context);

    return FilterChip(
      selected: isSelected,
      label: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.white : null,
          fontSize: 12,
        ),
      ),
      selectedColor: color ?? theme.colorScheme.primary,
      checkmarkColor: Colors.white,
      onSelected: (_) => onSelected(),
    );
  }
}
