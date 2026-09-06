import 'package:flutter/material.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';

class ProjectDetailsScreenshotGallery extends StatelessWidget {
  final Project project;
  final int visibleCount;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final VoidCallback onRetry;

  const ProjectDetailsScreenshotGallery({
    super.key,
    required this.project,
    required this.visibleCount,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasMore = visibleCount < project.screenshots.length;

    // For websites, show screenshots with actual size in a vertical list
    if (project.types.contains(ProjectType.website)) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: visibleCount + (hasMore ? 1 : 0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == visibleCount) {
            return _buildLoadMoreWidget();
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: project.screenshots[index].startsWith('http')
                    ? NetworkImage(project.screenshots[index])
                    : AssetImage(project.screenshots[index]) as ImageProvider,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                width: 600,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildImageLoadingIndicator(loadingProgress);
                },
                errorBuilder: (context, error, stackTrace) {
                  return _buildImageErrorWidget(context);
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      // For mobile apps, show horizontal scrolling carousel
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: visibleCount + (hasMore ? 1 : 0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == visibleCount) {
            return _buildLoadMoreWidget(isHorizontal: true);
          }

          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: project.screenshots[index].startsWith('http')
                    ? NetworkImage(project.screenshots[index])
                    : AssetImage(project.screenshots[index]) as ImageProvider,
                fit: BoxFit.cover,
                width: 300,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildImageLoadingIndicator(loadingProgress);
                },
                errorBuilder: (context, error, stackTrace) {
                  return _buildImageErrorWidget(context, width: 300);
                },
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildLoadMoreWidget({bool isHorizontal = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoadingMore) {
        onLoadMore();
      }
    });

    return Container(
      width: isHorizontal ? 120 : double.infinity,
      height: isHorizontal ? double.infinity : 100,
      margin: EdgeInsets.only(
        right: isHorizontal ? 15 : 0,
        bottom: isHorizontal ? 0 : 20,
      ),
      child: const Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildImageLoadingIndicator(ImageChunkEvent loadingProgress) {
    final expected = loadingProgress.expectedTotalBytes;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: expected != null && expected > 0
                ? loadingProgress.cumulativeBytesLoaded / expected
                : null,
          ),
          if (expected != null && expected > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${(loadingProgress.cumulativeBytesLoaded / 1024).round()} KB / ${(expected / 1024).round()} KB',
                style: const TextStyle(fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageErrorWidget(BuildContext context, {double? width}) {
    return Container(
      height: 200,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.broken_image, size: 50, color: Colors.grey),
          const SizedBox(height: 10),
          const Text(
            'Failed to load image',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
