import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/responsive.dart';
import 'package:my_protfolio/core/presentation/widgets/section_title.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_card.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_filter_bar.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_skeleton_layout.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_project_provider.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late ScrollController _scrollController;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Mobile',
    'Web',
    'Full Stack',
    'Flutter',
    'React',
    'Next.js',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProjectProvider>().loadProjects();
    });
  }

  void _filterProjects(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  List<Project> _getFilteredProjects(List<Project> allProjects) {
    if (_selectedCategory == 'All') {
      return List.from(allProjects);
    }
    final cat = _selectedCategory.toLowerCase();
    return allProjects.where((p) {
      if (cat == 'mobile') {
        return p.types.contains(ProjectType.mobile) ||
            p.typeNames.any((t) => t.toLowerCase().contains('mobile'));
      } else if (cat == 'web' || cat == 'website') {
        return p.types.contains(ProjectType.website) ||
            p.typeNames.any((t) => t.toLowerCase().contains('web') || t.toLowerCase().contains('website'));
      } else if (cat == 'full stack') {
        return p.isFullStack ||
            p.types.contains(ProjectType.fullstack) ||
            p.typeNames.any((t) => t.toLowerCase().replaceAll(' ', '') == 'fullstack');
      } else if (cat == 'flutter') {
        return p.types.contains(ProjectType.flutter) ||
            p.typeNames.any((t) => t.toLowerCase() == 'flutter') ||
            p.technologies.any((t) => t.toLowerCase() == 'flutter');
      } else if (cat == 'react') {
        return p.types.contains(ProjectType.react) ||
            p.typeNames.any((t) => t.toLowerCase() == 'react') ||
            p.technologies.any((t) => t.toLowerCase() == 'react');
      } else if (cat == 'next.js' || cat == 'next js') {
        return p.types.contains(ProjectType.nextjs) ||
            p.typeNames.any((t) => t.toLowerCase().contains('next')) ||
            p.technologies.any((t) => t.toLowerCase().contains('next'));
      }
      return p.technologies.any((tech) => tech.toLowerCase() == cat) ||
          p.typeNames.any((t) => t.toLowerCase() == cat);
    }).toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth < 850 ? 20 : (screenWidth < 1200 ? 40 : 100),
        vertical: screenWidth < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: AppTexts.projectsTitle),
          const SizedBox(height: 30),
          ProjectFilterBar(
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: _filterProjects,
          ),
          SizedBox(height: screenWidth < 850 ? 30 : 40),
          Consumer<AdminProjectProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading && provider.projects.isEmpty) {
                return Responsive(
                  mobile: const ProjectSkeletonLayout(isMobile: true),
                  desktop: const ProjectSkeletonLayout(isMobile: false),
                );
              }

              if (provider.projects.isEmpty) {
                return const SizedBox.shrink();
              }

              final all = provider.projects.map((p) {
                final rawTypes = p.types.isNotEmpty ? p.types : [p.projectType];
                final mappedTypes = rawTypes.map((typeStr) {
                  final s = typeStr.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
                  if (s.contains('mobile')) return ProjectType.mobile;
                  if (s.contains('web')) return ProjectType.website;
                  if (s.contains('fullstack')) return ProjectType.fullstack;
                  if (s.contains('flutter')) return ProjectType.flutter;
                  if (s.contains('react')) return ProjectType.react;
                  if (s.contains('next')) return ProjectType.nextjs;
                  return ProjectType.website;
                }).toSet().toList();

                return Project(
                  id: p.name,
                  title: p.name,
                  description: p.description,
                  imageUrl: p.imageUrl,
                  technologies: p.technologies,
                  screenshots: p.screenshots,
                  readmeContent: p.readMe,
                  demoUrl: p.previewUrl.isNotEmpty ? p.previewUrl : null,
                  codeUrl: p.githubUrl.isNotEmpty ? p.githubUrl : null,
                  types: mappedTypes.isNotEmpty ? mappedTypes : [ProjectType.website],
                  typeNames: rawTypes,
                  isFullStack: p.companyName.toLowerCase().contains('full stack') ||
                      p.technologies.any((t) => t.toLowerCase() == 'full stack') ||
                      rawTypes.any((t) => t.toLowerCase().replaceAll(' ', '').contains('fullstack')),
                  createdAt: p.createdAt,
                );
              }).toList();

              final filtered = _getFilteredProjects(all);

              return Responsive(
                mobile: _buildHorizontalScrollLayout(context, projects: filtered, isMobile: true),
                desktop: _buildHorizontalScrollLayout(context, projects: filtered, isMobile: false),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalScrollLayout(
    BuildContext context, {
    required List<Project> projects,
    required bool isMobile,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;

    if (projects.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No projects found in this category.',
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        // Header Row showing project counter badge
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primaryLight.withValues(alpha: 0.1)
                    : AppColors.primaryDark.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                '${projects.length} ${projects.length == 1 ? 'Project' : 'Projects'}',
                style: TextStyle(
                  fontSize: isMobile ? 12 : 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        // Horizontal scrollable list of cards
        SizedBox(
          height: isMobile ? 550 : 590,
          child: Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 30,
                vertical: isMobile ? 10 : 20,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ProjectCard(
                    project: projects[index],
                    index: index,
                    isMobile: isMobile,
                    isTablet: isTablet,
                    isDark: isDark,
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: (index * 100).ms)
                      .slideX(begin: 0.1, end: 0),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
