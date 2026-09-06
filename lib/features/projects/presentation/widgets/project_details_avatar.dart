import 'package:flutter/material.dart';
import 'package:my_protfolio/core/constants/colors.dart';

class ProjectDetailsAvatar extends StatelessWidget {
  final String imageUrl;

  const ProjectDetailsAvatar({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (imageUrl.isEmpty) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A3D4F) : const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.folder_rounded,
          size: 40,
          color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image(
        image: imageUrl.startsWith('http')
            ? NetworkImage(imageUrl)
            : AssetImage(imageUrl) as ImageProvider,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isDark ? const Color(0xFF2A3D4F) : const Color(0xFFEFEFEF),
            ),
            child: Center(
              child: Builder(
                builder: (context) {
                  final expected = loadingProgress.expectedTotalBytes;
                  return CircularProgressIndicator(
                    value: expected != null && expected > 0
                        ? loadingProgress.cumulativeBytesLoaded / expected
                        : null,
                  );
                },
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A3D4F) : const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.folder_rounded,
              size: 40,
              color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
            ),
          );
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
    );
  }
}
