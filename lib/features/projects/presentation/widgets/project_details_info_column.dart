import 'package:flutter/material.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_details_avatar.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_details_readme.dart';

class ProjectDetailsInfoColumn extends StatelessWidget {
  final Project project;
  final Future<void> Function(String url) onLaunchUrl;

  const ProjectDetailsInfoColumn({
    super.key,
    required this.project,
    required this.onLaunchUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project Avatar and Title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectDetailsAvatar(imageUrl: project.imageUrl),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                project.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Project Description
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 30),

        // Tech Stack
        Text(
          'Technologies',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: project.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primaryLight.withValues(alpha: 0.15)
                    : AppColors.primaryDark.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tech,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.primaryLight
                      : AppColors.primaryDark,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 30),

        // README Section
        Text(
          'README',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        ProjectDetailsReadme(project: project),
        const SizedBox(height: 30),

        // Links
        if (project.demoUrl != null && project.demoUrl!.isNotEmpty) ...[
          Text(
            'Links',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => onLaunchUrl(project.demoUrl!),
              icon: const Icon(Icons.open_in_new),
              label: const Text('View Demo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF64FFDA),
                foregroundColor: const Color(0xFF0A192F),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],

        if (project.codeUrl != null && project.codeUrl!.isNotEmpty) ...[
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => onLaunchUrl(project.codeUrl!),
              icon: const Icon(Icons.code),
              label: const Text('View Source Code'),
              style: OutlinedButton.styleFrom(
                foregroundColor:
                    isDark ? Colors.white70 : Colors.black54,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
