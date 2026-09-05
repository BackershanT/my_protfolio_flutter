import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/admin_project_model.dart';

class AdminProjectCardCover extends StatelessWidget {
  final AdminProjectModel project;
  final VoidCallback onTapScreenshots;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Widget Function(ThemeData theme) placeholderBuilder;

  const AdminProjectCardCover({
    super.key,
    required this.project,
    required this.onTapScreenshots,
    required this.onEdit,
    required this.onDelete,
    required this.placeholderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = project;

    return InkWell(
      onTap: onTapScreenshots,
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            p.imageUrl.isNotEmpty
                ? (p.imageUrl.startsWith('http')
                    ? Image.network(
                        p.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => placeholderBuilder(theme),
                      )
                    : Image.asset(
                        p.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => placeholderBuilder(theme),
                      ))
                : placeholderBuilder(theme),

            // Company tag badge
            if (p.companyName.isNotEmpty)
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.business_rounded, size: 12, color: Colors.amberAccent),
                      const SizedBox(width: 5),
                      Text(
                        p.companyName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Screenshots count badge
            if (p.screenshots.isNotEmpty)
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white24, width: 0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.photo_library_rounded, size: 11, color: Colors.cyanAccent),
                      const SizedBox(width: 4),
                      Text(
                        '${p.screenshots.length} Shots',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Actions overlay
            Positioned(
              top: 8,
              right: 8,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ActionButton(
                    icon: Icons.edit_outlined,
                    tooltip: 'Edit Project',
                    onPressed: onEdit,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 6),
                  _ActionButton(
                    icon: Icons.delete_outline_rounded,
                    tooltip: 'Delete Project',
                    onPressed: onDelete,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: 16, color: color),
        tooltip: tooltip,
        onPressed: onPressed,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
