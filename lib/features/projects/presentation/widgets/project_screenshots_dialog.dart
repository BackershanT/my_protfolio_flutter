import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';
import 'package:my_protfolio/features/projects/presentation/project_details_page.dart';

/// Modal dialog displaying high-res project screenshots in an interactive carousel lightbox.
class ProjectScreenshotsDialog extends StatefulWidget {
  final Project project;
  final int initialIndex;

  const ProjectScreenshotsDialog({
    super.key,
    required this.project,
    this.initialIndex = 0,
  });

  static Future<void> show(
    BuildContext context, {
    required Project project,
    int initialIndex = 0,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (context) => ProjectScreenshotsDialog(
        project: project,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  State<ProjectScreenshotsDialog> createState() => _ProjectScreenshotsDialogState();
}

class _ProjectScreenshotsDialogState extends State<ProjectScreenshotsDialog> {
  late final PageController _pageController;
  late int _currentIndex;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_currentIndex < widget.project.screenshots.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildImage(String url, {required bool isDark}) {
    final isNetwork = url.startsWith('http');
    return InteractiveViewer(
      minScale: 0.8,
      maxScale: 3.5,
      child: Center(
        child: isNetwork
            ? Image.network(
                url,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                          : null,
                      color: AppColors.primaryLight,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => _buildErrorWidget(isDark),
              )
            : Image.asset(
                url,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildErrorWidget(isDark),
              ),
      ),
    );
  }

  Widget _buildErrorWidget(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B2A4A) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.broken_image_rounded, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          const Text('Could not load screenshot', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final screenshots = widget.project.screenshots;

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _previousImage();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _nextImage();
          } else if (event.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 32,
          vertical: isMobile ? 16 : 32,
        ),
        child: Container(
          width: 1000,
          height: isMobile ? size.height * 0.85 : 750,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F1E36) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              // Top Bar Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    const Icon(Icons.collections_rounded, color: AppColors.primaryLight, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project.title,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (screenshots.isNotEmpty)
                            Text(
                              'Screenshot ${_currentIndex + 1} of ${screenshots.length}',
                              style: TextStyle(
                                fontSize: 12,
                                color: (isDark ? Colors.white70 : Colors.black54),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Show Full Details Button
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailsPage(project: widget.project),
                          ),
                        );
                      },
                      icon: const Icon(Icons.visibility_outlined, size: 16),
                      label: Text(isMobile ? 'Details' : 'Full Details'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Close button
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'Close (Esc)',
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // Main Content Area
              Expanded(
                child: screenshots.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              size: 64,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No screenshots uploaded for this project yet.',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectDetailsPage(project: widget.project),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryLight,
                                foregroundColor: const Color(0xFF0A192F),
                              ),
                              child: const Text('View Project Details'),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          // PageView for screenshots
                          PageView.builder(
                            controller: _pageController,
                            itemCount: screenshots.length,
                            onPageChanged: (idx) {
                              setState(() {
                                _currentIndex = idx;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(isMobile ? 12 : 24),
                                child: _buildImage(screenshots[index], isDark: isDark),
                              );
                            },
                          ),

                          // Previous Arrow Button
                          if (_currentIndex > 0)
                            Positioned(
                              left: 12,
                              child: _NavButton(
                                icon: Icons.arrow_back_ios_new_rounded,
                                onPressed: _previousImage,
                                tooltip: 'Previous',
                              ),
                            ),

                          // Next Arrow Button
                          if (_currentIndex < screenshots.length - 1)
                            Positioned(
                              right: 12,
                              child: _NavButton(
                                icon: Icons.arrow_forward_ios_rounded,
                                onPressed: _nextImage,
                                tooltip: 'Next',
                              ),
                            ),
                        ],
                      ),
              ),

              // Bottom Thumbnails Strip
              if (screenshots.length > 1) ...[
                const Divider(height: 1),
                Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: screenshots.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = index == _currentIndex;
                      final url = screenshots[index];
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? AppColors.primaryLight : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Opacity(
                            opacity: isSelected ? 1.0 : 0.5,
                            child: url.startsWith('http')
                                ? Image.network(url, fit: BoxFit.cover)
                                : Image.asset(url, fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const _NavButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.6),
      shape: const CircleBorder(),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onPressed,
        tooltip: tooltip,
      ),
    );
  }
}
