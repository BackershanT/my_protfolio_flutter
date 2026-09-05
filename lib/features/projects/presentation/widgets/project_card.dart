import 'package:flutter/material.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';
import 'package:my_protfolio/core/presentation/widgets/custom_cursor.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';
import 'package:my_protfolio/features/projects/presentation/project_details_page.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_screenshots_dialog.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final int index;
  final bool isMobile;
  final bool isTablet;
  final bool isDark;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.isMobile,
    required this.isTablet,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = isMobile ? 16.0 : (screenWidth < 1200 ? 20.0 : 22.0);
    final titleSize = isMobile ? 17.0 : (screenWidth < 1200 ? 19.0 : 21.0);
    final descSize = isMobile ? 13.0 : 14.0;
    final imageHeight = isMobile ? 180.0 : 210.0;

    final limitedTechStack = project.technologies.length > 4
        ? project.technologies.take(4).toList()
        : project.technologies;

    return TiltCard(
      maxTilt: isMobile ? 0 : 10,
      scale: isMobile ? 1.0 : 1.02,
      glareOpacity: 0.08,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            ProjectScreenshotsDialog.show(context, project: project);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: isMobile ? 295.0 : 360.0,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.06),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                      .withValues(alpha: isDark ? 0.08 : 0.05),
                  blurRadius: 20,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Project Cover Image Container (BoxFit.cover with full width)
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: project.imageUrl.isNotEmpty
                            ? (project.imageUrl.startsWith('http')
                                ? Image.network(
                                    project.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color: isDark ? const Color(0xFF1E2D3D) : Colors.grey.shade200,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                : null,
                                            strokeWidth: 2,
                                            color: AppColors.primaryLight,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return _buildImagePlaceholder(isDark, isMobile);
                                    },
                                  )
                                : Image.asset(
                                    project.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    errorBuilder: (context, error, stackTrace) {
                                      return _buildImagePlaceholder(isDark, isMobile);
                                    },
                                  ))
                            : _buildImagePlaceholder(isDark, isMobile),
                      ),

                      // Gradient overlay at image bottom for visual contrast
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.55),
                              ],
                              stops: const [0.65, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Screenshots count chip (bottom-right)
                      if (project.screenshots.isNotEmpty)
                        Positioned(
                          bottom: 10,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white24, width: 0.8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.photo_library_rounded, size: 13, color: AppColors.primaryLight),
                                const SizedBox(width: 5),
                                Text(
                                  '${project.screenshots.length} Shots',
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
                    ],
                  ),
                ),

                // Card Content Area
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: titleSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isMobile ? 8 : 10),

                      // Tech Stack Badges
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: limitedTechStack.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.primaryLight.withValues(alpha: 0.14)
                                  : AppColors.primaryDark.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                fontSize: isMobile ? 11 : 12,
                                fontWeight: FontWeight.w500,
                                color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: isMobile ? 10 : 12),

                      // Description
                      Text(
                        project.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: descSize,
                          height: 1.45,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isMobile ? 14 : 16),

                      // Action Buttons
                      Row(
                        children: [
                          if (project.screenshots.isNotEmpty) ...[
                            Expanded(
                              flex: 1,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  ProjectScreenshotsDialog.show(context, project: project);
                                },
                                icon: const Icon(Icons.collections_rounded, size: 14),
                                label: const Text(
                                  'Screenshots',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                                  side: BorderSide(
                                    color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                                        .withValues(alpha: 0.4),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 11),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ).withCursorHover(context),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectDetailsPage(project: project),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF64FFDA),
                                foregroundColor: const Color(0xFF0A192F),
                                padding: const EdgeInsets.symmetric(vertical: 11),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ).withCursorHover(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(bool isDark, bool isMobile) {
    return Container(
      color: isDark ? const Color(0xFF1E2D3D) : const Color(0xFFEFEFEF),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.primaryLight.withValues(alpha: 0.1)
                : AppColors.primaryDark.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.folder_open_rounded,
            size: isMobile ? 36.0 : 48.0,
            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
