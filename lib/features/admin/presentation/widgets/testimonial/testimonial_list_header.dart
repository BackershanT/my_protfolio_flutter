import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_search_bar.dart';

/// Header widget for the testimonials list.
///
/// Contains the page title, count badge, search bar, and "Add New" button.
/// Adapts layout for mobile vs desktop.
class TestimonialListHeader extends StatelessWidget {
  final int totalCount;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onAddNew;

  const TestimonialListHeader({
    super.key,
    required this.totalCount,
    required this.onSearchChanged,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width <= 600;

    if (isMobile) {
      return _buildMobileLayout(theme);
    }
    return _buildDesktopLayout(theme);
  }

  Widget _buildDesktopLayout(ThemeData theme) {
    return Row(
      children: [
        // Title + count
        Text(
          'Testimonials',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$totalCount',
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const Spacer(),
        // Search
        TestimonialSearchBar(onChanged: onSearchChanged),
        const SizedBox(width: 12),
        // Add button
        _buildAddButton(theme),
      ],
    );
  }

  Widget _buildMobileLayout(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Testimonials',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '$totalCount',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const Spacer(),
            _buildAddButton(theme),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TestimonialSearchBar(onChanged: onSearchChanged),
        ),
      ],
    );
  }

  Widget _buildAddButton(ThemeData theme) {
    return ElevatedButton.icon(
      onPressed: onAddNew,
      icon: const Icon(Icons.add_rounded, size: 20),
      label: const Text('Add New'),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.scaffoldBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }
}
