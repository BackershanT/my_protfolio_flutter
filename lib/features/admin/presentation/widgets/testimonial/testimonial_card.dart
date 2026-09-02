import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/testimonial_model.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/star_rating_widget.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/avatar_preview_widget.dart';

/// Card widget displaying a single testimonial.
///
/// Shows avatar, name, role, company, rating, content,
/// featured badge, and edit/delete action buttons.
class TestimonialCard extends StatefulWidget {
  final TestimonialModel testimonial;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TestimonialCard({
    super.key,
    required this.testimonial,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = widget.testimonial;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -4.0 : 0.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? theme.primaryColor.withOpacity(0.3)
                : theme.dividerColor.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? theme.primaryColor.withOpacity(0.08)
                  : Colors.black.withOpacity(0.05),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar & actions
            _buildHeader(theme, t),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '"${t.content}"',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.85),
                  ),
                ),
              ),
            ),
            // Footer with rating
            _buildFooter(theme, t),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, TestimonialModel t) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          AvatarPreviewWidget(
            avatarUrl: t.avatarUrl,
            name: t.name,
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        t.name,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (t.isFeatured)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.amber.withOpacity(0.3),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded,
                                size: 14, color: Colors.amber),
                            SizedBox(width: 3),
                            Text(
                              'Featured',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  t.company != null && t.company!.isNotEmpty
                      ? '${t.role} at ${t.company}'
                      : t.role,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(ThemeData theme, TestimonialModel t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: theme.dividerColor.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          StarRatingWidget(
            rating: t.rating,
            interactive: false,
            starSize: 18,
          ),
          const Spacer(),
          _ActionButton(
            icon: Icons.edit_outlined,
            tooltip: 'Edit',
            color: theme.primaryColor,
            onTap: widget.onEdit,
          ),
          const SizedBox(width: 4),
          _ActionButton(
            icon: Icons.delete_outline_rounded,
            tooltip: 'Delete',
            color: Colors.red,
            onTap: widget.onDelete,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor: color.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 20, color: color.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}
