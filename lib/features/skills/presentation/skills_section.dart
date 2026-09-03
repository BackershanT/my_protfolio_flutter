import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/responsive.dart';
import 'package:my_protfolio/core/presentation/widgets/section_title.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/providers/skill_provider.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';
import 'package:my_protfolio/features/skills/presentation/widgets/skill_card_widget.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  late PageController _pageController;
  late ScrollController _desktopScrollController;
  int _currentPage = 0;
  bool _isUserInteracting = false;
  Timer? _autoScrollTimer;
  Timer? _desktopScrollTimer;

  @override
  void initState() {
    super.initState();
    // Initialize with a default - didChangeDependencies will update it correctly
    _pageController = PageController(viewportFraction: 0.85, initialPage: 500);
    _desktopScrollController = ScrollController();

    _startMobileAutoScroll();
    _startDesktopAutoScroll();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SkillProvider>().loadSkills();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update viewport fraction if screen size changes
    // This method is called after initState and whenever dependencies (like MediaQuery) change
    final newFraction = Responsive.isMobile(context) ? 0.7 : 0.85;

    // Only recreate if necessary to prevent loop/unnecessary overhead
    if (_pageController.viewportFraction != newFraction) {
      final oldController = _pageController;
      final currentPage = oldController.hasClients
          ? (oldController.page ?? 500)
          : 500;

      _pageController = PageController(
        viewportFraction: newFraction,
        initialPage: currentPage.toInt(),
      );

      // Note: We don't dispose the old controller immediately here as it might be in use
      // by the current frame's build. The GC will handle it, or we could track and dispose later.
      // For this specific use case, it's acceptable.
    }
  }

  void _startMobileAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (!_isUserInteracting && _pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _startDesktopAutoScroll() {
    _resumeDesktopScroll();
  }

  void _resumeDesktopScroll() {
    _desktopScrollTimer?.cancel();
    _desktopScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_desktopScrollController.hasClients) {
        final currentScroll = _desktopScrollController.offset;
        final maxScroll = _desktopScrollController.position.maxScrollExtent;

        // Loop back if near end (though itemCount 1000 is huge)
        if (currentScroll >= maxScroll - 240) {
          _desktopScrollController.jumpTo(0);
          return;
        }

        _desktopScrollController.animateTo(
          currentScroll + 240.0, // Item width (200) + Padding (40)
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _pauseDesktopScroll() {
    _desktopScrollTimer?.cancel();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _desktopScrollTimer?.cancel();
    _pageController.dispose();
    _desktopScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (screenWidth < 1200 ? 40 : 100),
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: AppTexts.skillsTitle,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
          SizedBox(height: isMobile ? 40 : 80),
          Consumer<SkillProvider>(
            builder: (context, provider, child) {
              final isLoading = provider.isLoading;
              var items = provider.skills;
              if (items.isEmpty && !isLoading) {
                items = SkillData.getAllSkills();
              }
              
              if (isLoading && items.isEmpty) {
                 return Responsive(
                   mobile: _buildMobileSkeleton(context),
                   desktop: _buildDesktopSkeleton(context),
                 );
              }

              return Responsive(
                mobile: _buildMobileCarousel(context, items),
                desktop: _buildDesktopGrid(context, items),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCarousel(BuildContext context, List<dynamic> skills) {
    if (skills.isEmpty) return const SizedBox.shrink();
    
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(
          height: 350,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                setState(() => _isUserInteracting = true);
              } else if (notification is ScrollEndNotification) {
                setState(() => _isUserInteracting = false);
              }
              return false;
            },
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index % skills.length;
                });
              },
              itemCount: 1000,
              itemBuilder: (context, index) {
                final skillIndex = index % skills.length;
                final skill = skills[skillIndex];
                final isActive = _currentPage == skillIndex;

                return Center(
                  child: SkillCardWidget(
                    skill: skill,
                    isDark: isDark,
                    isActive: isActive,
                    isMobile: true,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 32),
        _buildPaginationDots(skills.length, isDark),
      ],
    );
  }

  Widget _buildPaginationDots(int count, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: isActive ? 28 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: isActive
                ? (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                : (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                      .withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(5),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color:
                          (isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark)
                              .withValues(alpha: 0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
        );
      }),
    );
  }

  Widget _buildDesktopGrid(BuildContext context, List<dynamic> skills) {
    if (skills.isEmpty) return const SizedBox.shrink();
    
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => _pauseDesktopScroll(),
      onExit: (_) => _resumeDesktopScroll(),
      child: SizedBox(
        height: 280,
        child: ListView.builder(
          controller: _desktopScrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: 1000,
          itemBuilder: (context, index) {
            final skillIndex = index % skills.length;
            final skill = skills[skillIndex];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child:
                  SkillCardWidget(
                        skill: skill,
                        isDark: isDark,
                        isActive: true,
                        isMobile: false,
                      )
                      .animate()
                      .fadeIn(delay: (skillIndex * 100).ms, duration: 600.ms)
                      .slideX(begin: 0.2, end: 0, curve: Curves.easeOutQuint),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMobileSkeleton(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Center(
                child: const _SkillSkeletonCard(isMobile: true),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopSkeleton(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        controller: _desktopScrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const _SkillSkeletonCard(isMobile: false),
          );
        },
      ),
    );
  }
}

class _SkillSkeletonCard extends StatelessWidget {
  final bool isMobile;
  const _SkillSkeletonCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;
    final skeletonColor = isDark ? Colors.white12 : Colors.black12;

    return Container(
      width: isMobile ? 220 : 200,
      height: isMobile ? 220 : 200,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF112240) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.1),
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isMobile ? 100 : 80,
              height: isMobile ? 100 : 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: skeletonColor,
              ),
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
            const SizedBox(height: 16),
            Container(
              width: isMobile ? 120 : 100,
              height: 18,
              color: skeletonColor,
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}


