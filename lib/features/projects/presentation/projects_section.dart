import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/shared/data/models/project_model.dart';
import 'package:my_protfolio/features/projects/data/models/project_data.dart';
import 'package:my_protfolio/features/projects/presentation/project_details_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late List<Project> _projects;

  @override
  void initState() {
    super.initState();
    _projects = ProjectData.getAllProjects();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width < 850
            ? 20
            : (MediaQuery.of(context).size.width < 1200 ? 40 : 100),
        vertical: MediaQuery.of(context).size.width < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: AppTexts.projectsTitle),
          SizedBox(height: MediaQuery.of(context).size.width < 850 ? 40 : 50),
          Responsive(
            mobile: _buildMobileLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildHorizontalScrollLayout(context, isMobile: true);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return _buildHorizontalScrollLayout(context, isMobile: false);
  }

  Widget _buildHorizontalScrollLayout(
    BuildContext context, {
    required bool isMobile,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;

    return Column(
      children: [
        // Project counter aligned to the right side
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '1/${_projects.length}',
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 20 : 30),
        // Horizontal scrollable list
        SizedBox(
          height: isMobile ? 500 : 550,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 30,
                vertical: isMobile ? 10 : 20,
              ),
              itemCount: _projects.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: 20, // Space between cards
                  ),
                  child: _buildProjectCard(
                    context,
                    _projects[index],
                    index,
                    isMobile: isMobile,
                    isTablet: isTablet,
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    Project project,
    int index, {
    required bool isMobile,
    required bool isTablet,
    required bool isDark,
  }) {
    // Responsive sizing based on about section card sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = isMobile ? 20.0 : (screenWidth < 1200 ? 24.0 : 30.0);
    final iconPadding = isMobile ? 12.0 : 16.0;
    final titleSize = isMobile ? 18.0 : (screenWidth < 1200 ? 20.0 : 24.0);
    final descSize = isMobile ? 14.0 : 16.0;
    final imageHeight = isMobile ? 150.0 : 200.0;

    // Limit tech stack to 3 items
    final limitedTechStack = project.technologies.length > 3
        ? project.technologies.take(3).toList()
        : project.technologies;

    return Container(
      width: isMobile ? 280.0 : 350.0, // Similar width to about section cards
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project image container
          Container(
            height: imageHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: project.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: project.imageUrl.startsWith('http')
                          ? NetworkImage(project.imageUrl)
                          : AssetImage(project.imageUrl) as ImageProvider,
                      fit: BoxFit.fill,
                    )
                  : null,
              color: project.imageUrl.isEmpty
                  ? (isDark ? const Color(0xFF2A3D4F) : const Color(0xFFEFEFEF))
                  : null,
            ),
            child: project.imageUrl.isEmpty
                ? Container(
                    padding: EdgeInsets.all(iconPadding),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.primaryLight.withOpacity(0.1)
                          : AppColors.primaryDark.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.folder_rounded,
                      size: isMobile ? 40.0 : 50.0,
                      color: isDark
                          ? AppColors.primaryLight
                          : AppColors.primaryDark,
                    ),
                  )
                : null,
          ),

          // Content area
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project title - limited to one line
                Text(
                  project.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: titleSize,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isMobile ? 16 : 24),

                // Tech stack - limited to 3 items and each tech name to 5 characters
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: limitedTechStack.map((tech) {
                    // Limit each tech name to 5 characters
                    final shortenedTech = tech.length > 5
                        ? '${tech.substring(0, 5)}...'
                        : tech;

                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.primaryLight.withOpacity(0.15)
                            : AppColors.primaryDark.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        shortenedTech,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.primaryLight
                              : AppColors.primaryDark,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: isMobile ? 12 : 16),

                // Project description - limited to two lines
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: descSize,
                    height: 1.6,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: isMobile ? 20 : 30),

                // Show Details button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProjectDetailsPage(project: project),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF64FFDA),
                      foregroundColor: const Color(0xFF0A192F),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 24,
                        vertical: isMobile ? 12 : 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Show Details',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}