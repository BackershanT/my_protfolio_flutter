import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/models/testimonial_model.dart';
import 'package:my_protfolio/features/admin/data/providers/testimonial_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_card.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_form_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_list_header.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_empty_state.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_delete_dialog.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_stats_bar.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/custom_snackbar.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Admin page for managing testimonials with full CRUD operations.
///
/// Features a responsive grid layout, search/filter, stats bar,
/// and custom dialogs for create, edit, and delete operations.
class AdminTestimonialsPage extends StatefulWidget {
  const AdminTestimonialsPage({super.key});

  @override
  State<AdminTestimonialsPage> createState() => _AdminTestimonialsPageState();
}

class _AdminTestimonialsPageState extends State<AdminTestimonialsPage> {
  @override
  void initState() {
    super.initState();
    // Load testimonials when the page is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TestimonialProvider>().loadTestimonials();
    });
  }

  Future<void> _handleAdd() async {
    final result = await TestimonialFormDialog.show(context);
    if (result == null || !mounted) return;

    final provider = context.read<TestimonialProvider>();
    final success = await provider.addTestimonial(result);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Testimonial added successfully!',
        type: SnackbarType.success,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to add testimonial',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleEdit(TestimonialModel testimonial) async {
    final result = await TestimonialFormDialog.show(
      context,
      testimonial: testimonial,
    );
    if (result == null || !mounted) return;

    final provider = context.read<TestimonialProvider>();
    final success = await provider.updateTestimonial(result);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Testimonial updated successfully!',
        type: SnackbarType.success,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: provider.error ?? 'Failed to update testimonial',
        type: SnackbarType.error,
      );
    }
  }

  Future<void> _handleDelete(TestimonialModel testimonial) async {
    if (testimonial.id == null) return;

    await TestimonialDeleteDialog.show(
      context,
      testimonialName: testimonial.name,
      onConfirm: () async {
        final provider = context.read<TestimonialProvider>();
        final success = await provider.deleteTestimonial(testimonial.id!);

        if (!mounted) return;
        if (success) {
          CustomSnackbar.show(
            context,
            message: 'Testimonial deleted successfully!',
            type: SnackbarType.success,
          );
        } else {
          CustomSnackbar.show(
            context,
            message: provider.error ?? 'Failed to delete testimonial',
            type: SnackbarType.error,
          );
        }
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width <= 600) return 1;
    if (width <= 1000) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestimonialProvider>(
      builder: (context, provider, _) {
        return RefreshIndicator(
          onRefresh: provider.loadTestimonials,
          child: _buildContent(provider),
        );
      },
    );
  }

  Widget _buildContent(TestimonialProvider provider) {
    final testimonials = provider.testimonials;

    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: TestimonialListHeader(
            totalCount: provider.totalCount,
            onSearchChanged: provider.setSearchQuery,
            onAddNew: _handleAdd,
          ),
        ),

        // Stats bar
        if (provider.totalCount > 0)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 8),
              child: TestimonialStatsBar(
                totalCount: provider.totalCount,
                featuredCount: provider.featuredCount,
                averageRating: provider.averageRating,
              ),
            ),
          ),

        // Error banner
        if (provider.error != null)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.2)),
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

        // Skeleton loading, empty state, or grid
        if (provider.isLoading && testimonials.isEmpty)
          _buildSkeletonGrid()
        else if (!provider.isLoading && testimonials.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: TestimonialEmptyState(onAddFirst: _handleAdd),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = _getCrossAxisCount(
                  constraints.crossAxisExtent,
                );
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.6,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final testimonial = testimonials[index];
                      return TestimonialCard(
                        testimonial: testimonial,
                        onEdit: () => _handleEdit(testimonial),
                        onDelete: () => _handleDelete(testimonial),
                      );
                    },
                    childCount: testimonials.length,
                  ),
                );
              },
            ),
          ),

        // Bottom spacing
        const SliverToBoxAdapter(
          child: SizedBox(height: 40),
        ),
      ],
    );
  }

  Widget _buildSkeletonGrid() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 20),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = _getCrossAxisCount(
            constraints.crossAxisExtent,
          );
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.6,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildSkeletonCard(),
              childCount: 6,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 80,
                        height: 11,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              width: 90,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 160,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1200.ms,
          color: Colors.white.withValues(alpha: 0.4),
        );
  }
}
