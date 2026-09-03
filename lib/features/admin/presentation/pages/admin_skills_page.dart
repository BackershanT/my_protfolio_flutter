import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';
import 'package:my_protfolio/features/admin/data/providers/skill_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/skill/skill_form_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/skill/skill_delete_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/skill/skill_empty_state.dart';
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

    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Manage Skills (${provider.totalCount})',
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _handleAdd,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Skill'),
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
              color: Colors.red.withOpacity(0.1),
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),

                                // Empty state or grid
        // Empty state or grid
        if (provider.isLoading && skills.isEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 20,
                                  color: Colors.grey.withValues(alpha: 0.2),
                                ),
                              ),
                              const SizedBox(width: 48), // Space for icons
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                        duration: 1200.ms,
                        color: Colors.white.withValues(alpha: 0.5),
                      );
                },
                childCount: 8, // Show 8 skeleton cards
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
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final skill = skills[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: skill.image.isNotEmpty
                              ? skill.image.startsWith('http')
                                  ? Image.network(
                                      skill.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.broken_image, size: 50),
                                    )
                                  : Image.asset(
                                      skill.image,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.broken_image, size: 50),
                                    )
                              : const Icon(Icons.image, size: 50),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  skill.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () => _handleEdit(skill),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                                onPressed: () => _handleDelete(skill),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: skills.length,
              ),
            ),
          ),
      ],
    );
  }
}
