import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/shared/data/models/project_model.dart';
import 'package:my_protfolio/features/projects/data/models/project_data.dart';
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
  late AnimationController _autoScrollController;
  bool _isPaused = false;
  int _currentIndex = 0;
  double _scrollProgress = 0.0;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Remove the auto-scroll controller as we're simplifying the scrolling behavior

    // Remove the delayed start since we're not auto-scrolling
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    // Remove autoScrollController dispose since we're not using it
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projects = ProjectData.getAllProjects();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width < 850 ? 20 : 
                    (MediaQuery.of(context).size.width < 1200 ? 40 : 100),
        vertical: MediaQuery.of(context).size.width < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: AppTexts.projectsTitle),
          SizedBox(height: MediaQuery.of(context).size.width < 850 ? 40 : 50),
          Responsive(
            mobile: _buildMobileLayout(context, projects),
            desktop: _buildDesktopLayout(context, projects),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<Project> projects) {
    return _buildScrollableProjects(context, projects, isMobile: true);
  }

  Widget _buildDesktopLayout(BuildContext context, List<Project> projects) {
    return _buildScrollableProjects(context, projects, isMobile: false);
  }

  Widget _buildScrollableProjects(BuildContext context, List<Project> projects, {required bool isMobile}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;
    
    return Container(
      height: isMobile ? 600 : (isTablet ? 650 : 700),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(32),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : (isTablet ? 40 : 60),
            vertical: isMobile ? 30 : 40,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _buildProjectCard(
              context,
              projects[index],
              index,
              isMobile: isMobile,
              isTablet: isTablet,
              isDark: isDark,
            );
          },
        ),
      ),
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
    return Container(
      margin: EdgeInsets.only(right: isMobile ? 20 : 30),
      width: isMobile ? 300 : (isTablet ? 350 : 400),
      height: isMobile ? 500 : (isTablet ? 550 : 600),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2D3D) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project image container
          Container(
            height: isMobile ? 180 : 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                ? Icon(
                    Icons.folder_rounded,
                    size: isMobile ? 60 : 80,
                    color: isDark ? const Color(0xFF64FFDA) : const Color(0xFF0A192F),
                  )
                : null,
          ),
          
          // Content area
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 20 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project title
                  Text(
                    project.title,
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Tech stack
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies.map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isDark 
                              ? const Color(0xFF64FFDA).withValues(alpha: 0.15) 
                              : const Color(0xFF0A192F).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tech,
                          style: TextStyle(
                            fontSize: isMobile ? 11 : 13,
                            fontWeight: FontWeight.w500,
                            color: isDark ? const Color(0xFF64FFDA) : const Color(0xFF0A192F),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Project description
                  Expanded(
                    child: Text(
                      project.description,
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 15,
                        height: 1.5,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (project.codeUrl != null)
                        TextButton.icon(
                          onPressed: () => _launchUrl(project.codeUrl!),
                          icon: Icon(
                            Icons.code,
                            size: isMobile ? 16 : 18,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                          label: Text(
                            'Code',
                            style: TextStyle(
                              fontSize: isMobile ? 13 : 15,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),
                      if (project.demoUrl != null)
                        ElevatedButton.icon(
                          onPressed: () => _launchUrl(project.demoUrl!),
                          icon: Icon(
                            Icons.open_in_new,
                            size: isMobile ? 16 : 18,
                          ),
                          label: Text(
                            'Demo',
                            style: TextStyle(
                              fontSize: isMobile ? 13 : 15,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF64FFDA),
                            foregroundColor: const Color(0xFF0A192F),
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16 : 20,
                              vertical: isMobile ? 10 : 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isDark,
    required bool isMobile,
    required bool isPrimary,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 20,
          vertical: isMobile ? 10 : 12,
        ),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? LinearGradient(
                  colors: [
                    AppColors.primaryDark,
                    AppColors.primaryDark.withValues(alpha: 0.8),
                  ],
                )
              : null,
          color: !isPrimary 
              ? (isDark 
                  ? const Color(0xFF4A4A4A).withValues(alpha: 0.7) 
                  : Colors.white)
              : null,
          borderRadius: BorderRadius.circular(12),
          border: !isPrimary
              ? Border.all(
                  color: isDark ? Colors.white38 : Colors.black26,
                  width: 1.5,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: isPrimary 
                  ? AppColors.primaryDark.withValues(alpha: 0.3) 
                  : (isDark ? Colors.black.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05)),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isMobile ? 16 : 18,
              color: isPrimary
                  ? Colors.white
                  : (isDark ? Colors.white : Colors.black87),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: isMobile ? 13 : 14,
                fontWeight: FontWeight.w600,
                color: isPrimary
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}