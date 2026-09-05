import 'package:flutter/material.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';

class ProjectDetailsReadme extends StatelessWidget {
  final Project project;

  const ProjectDetailsReadme({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<String?>(
      future: project.loadReadmeContent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A3D4F) : const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A3D4F) : const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              snapshot.data!,
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
                height: 1.6,
              ),
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A3D4F) : const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'No README content available',
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
            ),
          );
        }
      },
    );
  }
}
