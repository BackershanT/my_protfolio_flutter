import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/admin/data/models/admin_blog_model.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_blog_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_card.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_stats_bar.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_search_bar.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_empty_state.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_delete_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_form_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/custom_snackbar.dart';

/// Admin page for managing blogs with full CRUD operations.
class AdminBlogsPage extends StatefulWidget {
  const AdminBlogsPage({super.key});

  @override
  State<AdminBlogsPage> createState() => _AdminBlogsPageState();
}

class _AdminBlogsPageState extends State<AdminBlogsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminBlogProvider>().loadBlogs();
    });
  }

  Future<void> _handleAdd() async {
    final result = await AdminBlogFormDialog.show(context);
    if (result == null || !mounted) return;

    final provider = context.read<AdminBlogProvider>();
    final success = await provider.addBlog(result);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Blog post published successfully!',
        type: SnackbarType.success,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to publish blog post',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleEdit(AdminBlogModel blog) async {
    final result = await AdminBlogFormDialog.show(context, blog: blog);
    if (result == null || !mounted) return;

    final provider = context.read<AdminBlogProvider>();
    final success = await provider.updateBlog(blog.title, result);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Blog post updated successfully!',
        type: SnackbarType.success,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to update blog post',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleDelete(AdminBlogModel blog) async {
    await AdminBlogDeleteDialog.show(
      context,
      blogTitle: blog.title,
      onConfirm: () async {
        final provider = context.read<AdminBlogProvider>();
        final success = await provider.deleteBlog(blog.title);

        if (!mounted) return;
        if (success) {
          CustomSnackbar.show(
            context,
            message: 'Blog post deleted successfully!',
            type: SnackbarType.success,
          );
        } else {
          CustomSnackbar.show(
            context,
            message: provider.error ?? 'Failed to delete blog post',
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
    return Consumer<AdminBlogProvider>(
      builder: (context, provider, _) {
        return RefreshIndicator(
          onRefresh: provider.loadBlogs,
          child: _buildContent(provider),
        );
      },
    );
  }

  Widget _buildContent(AdminBlogProvider provider) {
    final blogs = provider.blogs;

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
                    'Manage Blogs (${provider.totalCount})',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _handleAdd,
                  icon: const Icon(Icons.add_rounded, size: 20),
                  label: const Text('Write Post'),
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
            child: AdminBlogStatsBar(
              totalCount: provider.totalCount,
              totalTechnologies: provider.allTechnologies.length,
            ),
          ),
        ),

        // Search and Technology Filter Bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: AdminBlogSearchBar(
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
        if (provider.isLoading && blogs.isEmpty)
          _buildSkeletonGrid()
        else if (!provider.isLoading && blogs.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: AdminBlogEmptyState(onAddFirst: _handleAdd),
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
                  childAspectRatio: crossAxisCount == 1 ? 1.4 : (crossAxisCount == 2 ? 0.78 : 0.75),
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final blog = blogs[index];
                    return AdminBlogCard(
                      blog: blog,
                      onEdit: () => _handleEdit(blog),
                      onDelete: () => _handleDelete(blog),
                    );
                  },
                  childCount: blogs.length,
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
            childAspectRatio: crossAxisCount == 1 ? 1.4 : (crossAxisCount == 2 ? 0.78 : 0.75),
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
          // Image thumbnail placeholder
          Container(
            height: 140,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title line 1
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                // Title line 2
                Container(
                  height: 16,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 14),
                // Excerpt line 1
                Container(
                  height: 11,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 6),
                // Excerpt line 2
                Container(
                  height: 11,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 16),
                // Chips placeholders
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
