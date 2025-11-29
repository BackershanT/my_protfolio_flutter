import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/data/models/project_model.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/presentation/footer_section.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;

  const ProjectDetailsPage({super.key, required this.project});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 850;

          if (isDesktop) {
            // Desktop layout with two sections
            return Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left section (1/3) - Project details
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Project Avatar and Title
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Project Avatar
                                  if (project.imageUrl.isNotEmpty)
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image:
                                              project.imageUrl.startsWith(
                                                'http',
                                              )
                                              ? NetworkImage(project.imageUrl)
                                              : AssetImage(project.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? const Color(0xFF2A3D4F)
                                            : const Color(0xFFEFEFEF),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.folder_rounded,
                                        size: 40,
                                        color: isDark
                                            ? AppColors.primaryLight
                                            : AppColors.primaryDark,
                                      ),
                                    ),
                                  const SizedBox(width: 20),
                                  // Project Title
                                  Expanded(
                                    child: Text(
                                      project.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
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
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.copyWith(height: 1.6),
                              ),
                              const SizedBox(height: 30),

                              // Tech Stack
                              Text(
                                'Technologies',
                                style: Theme.of(context).textTheme.headlineSmall
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
                                          ? AppColors.primaryLight.withOpacity(
                                              0.15,
                                            )
                                          : AppColors.primaryDark.withOpacity(
                                              0.1,
                                            ),
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
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF2A3D4F)
                                      : const Color(0xFFEFEFEF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: project.readmeContent != null
                                    ? Text(
                                        project.readmeContent!,
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black87,
                                          height: 1.6,
                                        ),
                                      )
                                    : Text(
                                        'No README content available',
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 30),

                              // Links
                              if (project.demoUrl != null &&
                                  project.demoUrl!.isNotEmpty) ...[
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
                                    onPressed: () =>
                                        _launchUrl(project.demoUrl!),
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

                              if (project.codeUrl != null &&
                                  project.codeUrl!.isNotEmpty) ...[
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () =>
                                        _launchUrl(project.codeUrl!),
                                    icon: const Icon(Icons.code),
                                    label: const Text('View Source Code'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      side: BorderSide(
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      // Right section (2/3) - Screenshots
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Screenshots',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              if (project.screenshots.isNotEmpty)
                                Expanded(
                                  child: project.type == ProjectType.website
                                      ? _buildScreenshotGallery(context)
                                      : SizedBox(
                                          height: double.infinity,
                                          child: _buildScreenshotGallery(
                                            context,
                                          ),
                                        ),
                                )
                              else
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF2A3D4F)
                                          : const Color(0xFFEFEFEF),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'No screenshots available',
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Footer for desktop view
                const FooterSection(),
              ],
            );
          } else {
            // Mobile layout
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Avatar and Title
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Project Avatar
                            if (project.imageUrl.isNotEmpty)
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: project.imageUrl.startsWith('http')
                                        ? NetworkImage(project.imageUrl)
                                        : AssetImage(project.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF2A3D4F)
                                      : const Color(0xFFEFEFEF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.folder_rounded,
                                  size: 40,
                                  color: isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primaryDark,
                                ),
                              ),
                            const SizedBox(width: 20),
                            // Project Title
                            Expanded(
                              child: Text(
                                project.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Project Description
                        Text(
                          project.description,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(height: 1.6),
                        ),
                        const SizedBox(height: 30),

                        // Tech Stack
                        Text(
                          'Technologies',
                          style: Theme.of(context).textTheme.headlineSmall
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
                                    ? AppColors.primaryLight.withOpacity(0.15)
                                    : AppColors.primaryDark.withOpacity(0.1),
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

                        // Screenshots Section
                        Text(
                          'Screenshots',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        if (project.screenshots.isNotEmpty)
                          // For websites, show with fixed height; for mobile apps, use horizontal carousel
                          SizedBox(
                            height: 300, // Fixed height for both types
                            child: _buildScreenshotGallery(context),
                          )
                        else
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF2A3D4F)
                                  : const Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'No screenshots available',
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 30),

                        // README Section
                        Text(
                          'README',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2A3D4F)
                                : const Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: project.readmeContent != null
                              ? Text(
                                  project.readmeContent!,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                    height: 1.6,
                                  ),
                                )
                              : Text(
                                  'No README content available',
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 30),

                        // Links
                        if (project.demoUrl != null &&
                            project.demoUrl!.isNotEmpty) ...[
                          Text(
                            'Links',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => _launchUrl(project.demoUrl!),
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

                        if (project.codeUrl != null &&
                            project.codeUrl!.isNotEmpty) ...[
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () => _launchUrl(project.codeUrl!),
                              icon: const Icon(Icons.code),
                              label: const Text('View Source Code'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isDark
                                    ? Colors.white70
                                    : Colors.black54,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: BorderSide(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Footer for mobile view
                const FooterSection(),
              ],
            );
          }
        },
      ),
    );
  }

  /// Builds the screenshot gallery with different display modes based on project type
  Widget _buildScreenshotGallery(BuildContext context) {
    // Limit the number of screenshots to prevent performance issues
    final int screenshotCount = project.screenshots.length > 10
        ? 10
        : project.screenshots.length;

    // For websites, show screenshots with actual size
    if (project.type == ProjectType.website) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: screenshotCount, // Limit screenshots for better performance
        cacheExtent: 1000, // Cache widgets for better performance
        physics: const BouncingScrollPhysics(), // Add smooth scrolling
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
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
                    : AssetImage(project.screenshots[index]),
                fit: BoxFit.contain,
                alignment: Alignment.center,
                width: 600, // Limit width for better performance
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
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
        itemCount: screenshotCount, // Limit screenshots for better performance
        cacheExtent: 1000, // Cache widgets for better performance
        physics: const BouncingScrollPhysics(), // Add smooth scrolling
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: project.screenshots[index].startsWith('http')
                    ? NetworkImage(project.screenshots[index])
                    : AssetImage(project.screenshots[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    }
  }
}
