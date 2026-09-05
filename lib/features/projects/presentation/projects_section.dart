import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/responsive.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';
import 'package:my_protfolio/core/presentation/widgets/section_title.dart';
import 'package:my_protfolio/features/projects/data/models/project_model.dart';
import 'package:my_protfolio/features/projects/data/models/project_data.dart';
import 'package:my_protfolio/features/projects/presentation/project_details_page.dart';
import 'package:my_protfolio/features/projects/presentation/widgets/project_screenshots_dialog.dart';
import 'package:my_protfolio/core/presentation/widgets/custom_cursor.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_project_provider.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  String _selectedCategory = 'All';
  String _selectedSortOrder = 'FIFO'; // Options: 'FIFO', 'LIFO', 'A-Z', 'Z-A'
  final List<String> _categories = [
    'All',
    'Mobile',
    'Website',
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
    List<Project> filtered;
    if (_selectedCategory == 'All') {
      filtered = List.from(allProjects);
    } else {
      final cat = _selectedCategory.toLowerCase();
      filtered = allProjects.where((p) {
        if (cat == 'mobile') {
          return p.types.contains(ProjectType.mobile) ||
              p.typeNames.any((t) => t.toLowerCase() == 'mobile');
        } else if (cat == 'website') {
          return p.types.contains(ProjectType.website) ||
              p.typeNames.any((t) => t.toLowerCase() == 'website');
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

    // Apply Sort Order (FIFO, LIFO, A-Z, Z-A)
    switch (_selectedSortOrder) {
      case 'FIFO':
        // FIFO (First-In, First-Out): Earliest/oldest added projects appear first
        filtered.sort((a, b) {
          final idA = int.tryParse(a.id);
          final idB = int.tryParse(b.id);
          if (idA != null && idB != null) {
            return idA.compareTo(idB);
          }
          if (a.createdAt != null && b.createdAt != null) {
            return a.createdAt!.compareTo(b.createdAt!);
          }
          return 0; // retain natural FIFO insertion order
        });
        break;
      case 'LIFO':
        // LIFO (Last-In, First-Out): Most recently added projects appear first
        filtered.sort((a, b) {
          final idA = int.tryParse(a.id);
          final idB = int.tryParse(b.id);
          if (idA != null && idB != null) {
            return idB.compareTo(idA);
          }
          if (a.createdAt != null && b.createdAt != null) {
            return b.createdAt!.compareTo(a.createdAt!);
          }
          return 0;
        });
        break;
      case 'A-Z':
        filtered.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case 'Z-A':
        filtered.sort((a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        break;
    }

    return filtered;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }



  Widget _buildFilterBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () => _filterProjects(category),
              borderRadius: BorderRadius.circular(25),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryLight
                      : (isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.05)),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryLight
                        : (isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black.withValues(alpha: 0.1)),
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF0A192F)
                        : (isDark ? Colors.white70 : Colors.black87),
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ).withCursorHover(context),
          );
        }).toList(),
      ),
    );
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
          const SizedBox(height: 30),
          _buildFilterBar(),
          SizedBox(height: MediaQuery.of(context).size.width < 850 ? 30 : 40),
          Consumer<AdminProjectProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading && provider.projects.isEmpty) {
                return Responsive(
                  mobile: _buildSkeletonLayout(context, isMobile: true),
                  desktop: _buildSkeletonLayout(context, isMobile: false),
                );
              }

              final List<Project> all;
              if (provider.projects.isNotEmpty) {
                all = provider.projects.map((p) {
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
              } else {
                all = ProjectData.getAllProjects(fifo: true);
              }

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

  Widget _buildSkeletonLayout(BuildContext context, {required bool isMobile}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: isMobile ? 500 : 550,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 30, vertical: isMobile ? 10 : 20),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 20),
            width: isMobile ? 280 : 360,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF112240) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: isMobile ? 180 : 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white12 : Colors.grey.shade200,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18,
                        width: 140,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white12 : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 12,
                        width: 180,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(
                duration: 1200.ms,
                color: Colors.white.withValues(alpha: isDark ? 0.08 : 0.35),
              );
        },
      ),
    );
  }

  Widget _buildSortOrderSelector({required bool isDark, required bool isMobile}) {
    final sortLabels = {
      'FIFO': 'FIFO (Oldest First)',
      'LIFO': 'LIFO (Newest First)',
      'A-Z': 'Name (A to Z)',
      'Z-A': 'Name (Z to A)',
    };

    return PopupMenuButton<String>(
      onSelected: (value) {
        setState(() {
          _selectedSortOrder = value;
        });
      },
      color: isDark ? const Color(0xFF112240) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => [
        _buildSortMenuItem('FIFO', 'FIFO (First In, First Out)', Icons.arrow_downward_rounded, isDark),
        _buildSortMenuItem('LIFO', 'LIFO (Newest First)', Icons.arrow_upward_rounded, isDark),
        _buildSortMenuItem('A-Z', 'Name (A to Z)', Icons.sort_by_alpha_rounded, isDark),
        _buildSortMenuItem('Z-A', 'Name (Z to A)', Icons.sort_by_alpha_rounded, isDark),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 16,
          vertical: isMobile ? 6 : 8,
        ),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? AppColors.primaryLight.withValues(alpha: 0.3) : AppColors.primaryDark.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.swap_vert_rounded,
              size: isMobile ? 16 : 18,
              color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
            ),
            const SizedBox(width: 6),
            Text(
              'Sort: ${sortLabels[_selectedSortOrder] ?? _selectedSortOrder}',
              style: TextStyle(
                fontSize: isMobile ? 12 : 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 18,
              color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
            ),
          ],
        ),
      ).withCursorHover(context),
    );
  }

  PopupMenuItem<String> _buildSortMenuItem(
    String value,
    String label,
    IconData icon,
    bool isDark,
  ) {
    final isSelected = _selectedSortOrder == value;
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected
                ? (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                : (isDark ? Colors.white70 : Colors.black87),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                    : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_rounded,
              size: 16,
              color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
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
        // Header Row: Sort Order selector on left, project counter on right
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSortOrderSelector(isDark: isDark, isMobile: isMobile),
            Text(
              '${projects.length} Projects',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                    .withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 15 : 20),
        // Horizontal scrollable list
        SizedBox(
          height: isMobile ? 570 : 615,
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
                  padding: const EdgeInsets.only(
                    right: 20, // Space between cards
                  ),
                  child:
                      _buildProjectCard(
                            context,
                            projects[index],
                            index,
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
    final padding = isMobile ? 16.0 : (screenWidth < 1200 ? 20.0 : 24.0);
    final iconPadding = isMobile ? 12.0 : 16.0;
    final titleSize = isMobile ? 17.0 : (screenWidth < 1200 ? 19.0 : 22.0);
    final descSize = isMobile ? 13.5 : 14.5;
    final imageHeight = isMobile ? 150.0 : 185.0;

    // Limit tech stack to 3 items
    final limitedTechStack = project.technologies.length > 3
        ? project.technologies.take(3).toList()
        : project.technologies;

    return TiltCard(
      maxTilt: isMobile ? 0 : 12,
      scale: isMobile ? 1.0 : 1.02,
      glareOpacity: 0.1,
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
            width: isMobile ? 290.0 : 350.0,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                      .withValues(alpha: isDark ? 0.10 : 0.06),
                  blurRadius: 24,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project image container with badges & tap action
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          image: project.imageUrl.isNotEmpty
                              ? DecorationImage(
                                  image: project.imageUrl.startsWith('http')
                                      ? NetworkImage(project.imageUrl)
                                      : ResizeImage.resizeIfNeeded(
                                          700,
                                          null,
                                          AssetImage(project.imageUrl),
                                        ),
                                  fit: BoxFit.cover,
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
                                      ? AppColors.primaryLight.withValues(alpha: 0.1)
                                      : AppColors.primaryDark.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.folder_rounded,
                                  size: isMobile ? 40.0 : 50.0,
                                  color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                                ),
                              )
                            : null,
                      ),

                      // Project Type Badge (top-left)
                      if (project.resolvedTypeNames.isNotEmpty)
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF64FFDA),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Text(
                              project.resolvedTypeNames.first,
                              style: const TextStyle(
                                color: Color(0xFF0A192F),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                      // Screenshots count chip (bottom-right)
                      if (project.screenshots.isNotEmpty)
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.75),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white24, width: 0.8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.photo_library_rounded, size: 12, color: AppColors.primaryLight),
                                const SizedBox(width: 4),
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

                // Content area
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
                      SizedBox(height: isMobile ? 8 : 12),

                      // Tech tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: limitedTechStack.map((tech) {
                          final shortenedTech = tech.length > 7
                              ? '${tech.substring(0, 7)}..'
                              : tech;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.primaryLight.withValues(alpha: 0.15)
                                  : AppColors.primaryDark.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              shortenedTech,
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

                      // Description: 4-5 lines with ellipsis
                      Text(
                        project.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: descSize,
                          height: 1.45,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isMobile ? 14 : 18),

                      // Bottom Action Buttons: Screenshots & Details
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
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ).withCursorHover(context),
                            ),
                            const SizedBox(width: 8),
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
                                  borderRadius: BorderRadius.circular(8),
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
}
