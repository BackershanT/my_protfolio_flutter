import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';

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
          Responsive(
            mobile: _buildMobileCarousel(context),
            desktop: _buildDesktopGrid(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCarousel(BuildContext context) {
    final skills = SkillData.getAllSkills();
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
                  child: _SkillCard(
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
                      .withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color:
                          (isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark)
                              .withOpacity(0.4),
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

  Widget _buildDesktopGrid(BuildContext context) {
    final skills = SkillData.getAllSkills();
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
                  _SkillCard(
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
}

class _SkillCard extends StatefulWidget {
  final SkillModel skill;
  final bool isDark;
  final bool isActive;
  final bool isMobile;

  const _SkillCard({
    required this.skill,
    required this.isDark,
    required this.isActive,
    required this.isMobile,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isDark
        ? AppColors.primaryLight
        : AppColors.primaryDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: widget.isMobile
            ? (widget.isActive ? 1.0 : 0.8)
            : (_isHovered ? 1.05 : 0.95),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        child: AnimatedOpacity(
          opacity: widget.isActive || _isHovered ? 1.0 : 0.6,
          duration: const Duration(milliseconds: 400),
          child: Container(
            width: widget.isMobile ? 220 : 200,
            height: widget.isMobile ? 220 : 200,
            decoration: BoxDecoration(
              color: widget.isDark
                  ? const Color(0xFF112240).withOpacity(0.8)
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: (widget.isActive || _isHovered)
                    ? primaryColor.withOpacity(0.5)
                    : primaryColor.withOpacity(0.1),
                width: 2,
              ),
              boxShadow: [
                if (widget.isActive || _isHovered)
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                    spreadRadius: 2,
                  )
                else
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
              ],
            ),
            child: Stack(
              children: [
                if (widget.isActive || _isHovered)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: RadialGradient(
                          colors: [
                            primaryColor.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                            tag:
                                'skill_${widget.skill.label}_${widget.isMobile}_${widget.isActive}',
                            child: Image.asset(
                              widget.skill.assetPath,
                              width: widget.isMobile ? 100 : 80,
                              height: widget.isMobile ? 100 : 80,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.code,
                                    size: 60,
                                    color: primaryColor.withOpacity(0.5),
                                  ),
                            ),
                          )
                          .animate(
                            target: widget.isMobile
                                ? (widget.isActive ? 1 : 0)
                                : (_isHovered ? 1 : 0),
                          )
                          .shimmer(
                            duration: 1200.ms,
                            color: primaryColor.withOpacity(0.3),
                          )
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.15, 1.15),
                            curve: Curves.easeOutBack,
                          )
                          .rotate(
                            begin: 0,
                            end: widget.isMobile ? 0 : 0.05,
                            curve: Curves.easeOutBack,
                          ),
                      const SizedBox(height: 16),
                      Text(
                            widget.skill.label,
                            style: TextStyle(
                              fontSize: widget.isMobile ? 18 : 16,
                              fontWeight: FontWeight.bold,
                              color: widget.isDark
                                  ? Colors.white
                                  : AppColors.primaryDark,
                              letterSpacing: 1.1,
                            ),
                          )
                          .animate(
                            target: widget.isMobile
                                ? (widget.isActive ? 1 : 0)
                                : (_isHovered ? 1 : 0),
                          )
                          .fadeIn()
                          .slideY(begin: 0.2, end: 0)
                          .tint(color: primaryColor, begin: 0, end: 0.2),
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
