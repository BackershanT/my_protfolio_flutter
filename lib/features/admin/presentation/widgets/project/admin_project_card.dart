import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_protfolio/features/admin/data/models/admin_project_model.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_screenshots_dialog.dart';

/// Card widget displaying a project in the admin dashboard.
class AdminProjectCard extends StatefulWidget {
  final AdminProjectModel project;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AdminProjectCard({
    super.key,
    required this.project,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<AdminProjectCard> createState() => _AdminProjectCardState();
}

class _AdminProjectCardState extends State<AdminProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    if (url.trim().isEmpty) return;
    final uri = Uri.tryParse(url.trim());
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _openScreenshots(BuildContext context) {
    final p = widget.project;
    final projectObj = Project(
      id: p.name,
      title: p.name,
      description: p.description,
      imageUrl: p.imageUrl,
      technologies: p.technologies,
      screenshots: p.screenshots,
      readmeContent: p.readMe,
      demoUrl: p.previewUrl,
      codeUrl: p.githubUrl,
      typeNames: p.types,
    );
    ProjectScreenshotsDialog.show(context, project: projectObj);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -4.0 : 0.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? theme.primaryColor.withValues(alpha: 0.35)
                : theme.dividerColor.withValues(alpha: 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? theme.primaryColor.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image Thumbnail with overlays & tap to view screenshots
            InkWell(
              onTap: () => _openScreenshots(context),
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
                                errorBuilder: (_, __, ___) => _buildPlaceholder(theme),
                              )
                            : Image.asset(
                                p.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _buildPlaceholder(theme),
                              ))
                        : _buildPlaceholder(theme),

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

                    // Screenshots count badge (bottom-right)
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
                            onPressed: widget.onEdit,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 6),
                          _ActionButton(
                            icon: Icons.delete_outline_rounded,
                            tooltip: 'Delete Project',
                            onPressed: widget.onDelete,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Card Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Name
                    Text(
                      p.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Project Type Badges
                    if (p.types.isNotEmpty) ...[
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: p.types.map((type) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              type,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 4),
                    ],

                    // Description: up to 4 lines with ellipsis
                    Expanded(
                      child: Text(
                        p.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                          height: 1.35,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Technologies Tags
                    if (p.technologies.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: p.technologies.take(3).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: theme.primaryColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: theme.primaryColor,
                              ),
                            ),
                          );
                        }).toList()
                          ..addAll(
                            p.technologies.length > 3
                                ? [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: theme.dividerColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '+${p.technologies.length - 3}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: theme.hintColor,
                                        ),
                                      ),
                                    ),
                                  ]
                                : [],
                          ),
                      ),

                    const Divider(height: 16),

                    // Links Row
                    Row(
                      children: [
                        if (p.githubUrl.isNotEmpty)
                          _LinkIcon(
                            icon: Icons.code_rounded,
                            tooltip: 'GitHub',
                            onTap: () => _launchUrl(p.githubUrl),
                          ),
                        if (p.previewUrl.isNotEmpty)
                          _LinkIcon(
                            icon: Icons.open_in_new_rounded,
                            tooltip: 'Live Demo',
                            onTap: () => _launchUrl(p.previewUrl),
                          ),
                        if (p.playStoreUrl.isNotEmpty)
                          _LinkIcon(
                            icon: Icons.shop_two_rounded,
                            tooltip: 'Play Store',
                            onTap: () => _launchUrl(p.playStoreUrl),
                          ),
                        if (p.appStoreUrl.isNotEmpty)
                          _LinkIcon(
                            icon: Icons.apple_rounded,
                            tooltip: 'App Store',
                            onTap: () => _launchUrl(p.appStoreUrl),
                          ),
                        if (p.videosUrl.isNotEmpty)
                          _LinkIcon(
                            icon: Icons.play_circle_outline_rounded,
                            tooltip: 'Video Demo',
                            onTap: () => _launchUrl(p.videosUrl),
                          ),
                        const Spacer(),
                        if (p.screenshots.isNotEmpty)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.photo_library_outlined, size: 14, color: theme.hintColor),
                              const SizedBox(width: 4),
                              Text(
                                '${p.screenshots.length}',
                                style: TextStyle(fontSize: 11, color: theme.hintColor),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      color: theme.primaryColor.withValues(alpha: 0.06),
      child: Center(
        child: Icon(
          Icons.folder_rounded,
          size: 48,
          color: theme.primaryColor.withValues(alpha: 0.3),
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

class _LinkIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _LinkIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: IconButton(
        icon: Icon(icon, size: 18, color: theme.hintColor),
        tooltip: tooltip,
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
        padding: EdgeInsets.zero,
        splashRadius: 16,
      ),
    );
  }
}
