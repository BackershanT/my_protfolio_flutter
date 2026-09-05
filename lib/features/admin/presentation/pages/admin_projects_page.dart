import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/admin/data/models/admin_project_model.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_project_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_card.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_stats_bar.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_search_bar.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_empty_state.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_delete_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_form_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/custom_snackbar.dart';

/// Admin page for managing projects with full CRUD operations.
class AdminProjectsPage extends StatefulWidget {
  const AdminProjectsPage({super.key});

  @override
  State<AdminProjectsPage> createState() => _AdminProjectsPageState();
}

class _AdminProjectsPageState extends State<AdminProjectsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProjectProvider>().loadProjects();
    });
  }

  Future<void> _handleAdd() async {
    final result = await AdminProjectFormDialog.show(context);
    if (result == null || !mounted) return;

    final provider = context.read<AdminProjectProvider>();
    final success = await provider.addProject(result);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Project created successfully!',
        type: SnackbarType.success,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to create project',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleEdit(AdminProjectModel project) async {
    final result = await AdminProjectFormDialog.show(context, project: project);
    if (result == null || !mounted) return;

    final provider = context.read<AdminProjectProvider>();
    final success = await provider.updateProject(project.name, result);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Project updated successfully!',
        type: SnackbarType.success,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to update project',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleDelete(AdminProjectModel project) async {
    await AdminProjectDeleteDialog.show(
      context,
      projectName: project.name,
      onConfirm: () async {
        final provider = context.read<AdminProjectProvider>();
        final success = await provider.deleteProject(project.name);

        if (!mounted) return;
        if (success) {
          CustomSnackbar.show(
            context,
            message: 'Project deleted successfully!',
            type: SnackbarType.success,
          );
        } else {
          CustomSnackbar.show(
            context,
            message: provider.error ?? 'Failed to delete project',
            type: SnackbarType.error,
          );
        }
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width <= 650) return 1;
    if (width <= 1100) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProjectProvider>(
      builder: (context, provider, _) {
        return RefreshIndicator(
          onRefresh: provider.loadProjects,
          child: _buildContent(provider),
        );
      },
    );
  }

  Widget _buildContent(AdminProjectProvider provider) {
    final projects = provider.projects;

    return CustomScrollView(
      slivers: [
        // Header with Add button
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Manage Projects (${provider.totalCount})',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _handleAdd,
                  icon: const Icon(Icons.add_rounded, size: 20),
                  label: const Text('Add Project'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Stats Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AdminProjectStatsBar(
              totalCount: provider.totalCount,
              companiesCount: provider.companiesCount,
              technologiesCount: provider.allTechnologies.length,
            ),
          ),
        ),

        // Search and Technology Filter Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: AdminProjectSearchBar(
              onSearchChanged: provider.setSearchQuery,
              onTechnologySelected: provider.setSelectedTechnology,
              initialSearch: provider.searchQuery,
              selectedTechnology: provider.selectedTechnology,
              availableTechnologies: provider.allTechnologies,
            ),
          ),
        ),

        // Error Banner
        if (provider.error != null)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      provider.error!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                  IconButton(
                    onPressed: provider.clearError,
                    icon: const Icon(Icons.close, size: 18, color: Colors.red),
                    splashRadius: 16,
                  ),
                ],
              ),
            ),
          ),

        // Content: Skeleton Loading, Empty State, or Grid
        if (provider.isLoading && projects.isEmpty)
          _buildSkeletonGrid()
        else if (!provider.isLoading && projects.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: AdminProjectEmptyState(onAddFirst: _handleAdd),
          )
        else
          SliverLayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = _getCrossAxisCount(constraints.crossAxisExtent);
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: crossAxisCount == 1 ? 1.4 : 0.82,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final project = projects[index];
                    return AdminProjectCard(
                      project: project,
                      onEdit: () => _handleEdit(project),
                      onDelete: () => _handleDelete(project),
                    );
                  },
                  childCount: projects.length,
                ),
              );
            },
          ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 40),
        ),
      ],
    );
  }

  Widget _buildSkeletonGrid() {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(constraints.crossAxisExtent);
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: crossAxisCount == 1 ? 1.4 : 0.82,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildSkeletonCard(),
            childCount: 6,
          ),
        );
      },
    );
  }

  Widget _buildSkeletonCard() {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 11,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 11,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1200.ms,
          color: Colors.white.withValues(alpha: 0.4),
        );
  }
}
