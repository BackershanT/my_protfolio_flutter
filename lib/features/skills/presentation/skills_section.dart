import 'package:flutter/material.dart';
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

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late ScrollController _desktopScrollController;
  late AnimationController _autoScrollController;
  late AnimationController _desktopAutoScrollController;
  int _currentPage = 0;
  bool _isUserInteracting = false;
  bool _isHoveringDesktop = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _desktopScrollController = ScrollController();
    _autoScrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _desktopAutoScrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    // Start auto-scroll after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _startAutoScroll();
        _startDesktopAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    if (!_pageController.hasClients || _isUserInteracting) return;

    _autoScrollController.addListener(() {
      if (_autoScrollController.status == AnimationStatus.completed) {
        if (mounted && !_isUserInteracting && _pageController.hasClients) {
          final nextPage = (_currentPage + 1) % SkillData.getAllSkills().length;
          _pageController
              .animateToPage(
                nextPage,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              )
              .then((_) {
                if (mounted && !_isUserInteracting) {
                  _autoScrollController.reset();
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted && !_isUserInteracting) {
                      _autoScrollController.forward();
                    }
                  });
                }
              });
        }
      }
    });

    _autoScrollController.forward();
  }

  void _startDesktopAutoScroll() {
    if (!_desktopScrollController.hasClients || _isHoveringDesktop) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_desktopScrollController.hasClients) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) _startDesktopAutoScroll();
        });
        return;
      }

      final maxScroll = _desktopScrollController.position.maxScrollExtent;
      final startPosition = _desktopScrollController.offset;

      _desktopAutoScrollController.addListener(() {
        if (_desktopScrollController.hasClients && !_isHoveringDesktop) {
          final offset =
              startPosition +
              (maxScroll - startPosition) * _desktopAutoScrollController.value;
          _desktopScrollController.jumpTo(offset);
        }
      });

      _desktopAutoScrollController.repeat();
    });
  }

  void _pauseDesktopScroll() {
    setState(() => _isHoveringDesktop = true);
    _desktopAutoScrollController.stop();
  }

  void _resumeDesktopScroll() {
    setState(() => _isHoveringDesktop = false);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && !_isHoveringDesktop) {
        _desktopAutoScrollController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _desktopScrollController.dispose();
    _autoScrollController.dispose();
    _desktopAutoScrollController.dispose();
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
          SectionTitle(title: AppTexts.skillsTitle),
          SizedBox(height: screenWidth < 850 ? 40 : 60),
          Responsive(
            mobile: _buildMobileCarousel(context),
            desktop: _buildDesktopGrid(context),
          ),
        ],
      ),
    );
  }

  // Mobile: Swipeable carousel with pagination dots
  Widget _buildMobileCarousel(BuildContext context) {
    final skills = SkillData.getAllSkills();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(
          height: 280,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                setState(() => _isUserInteracting = true);
                _autoScrollController.stop();
              } else if (notification is ScrollEndNotification) {
                setState(() => _isUserInteracting = false);
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted && !_isUserInteracting) {
                    _autoScrollController.reset();
                    _autoScrollController.forward();
                  }
                });
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
              itemCount: skills.length * 100, // Infinite scroll
              itemBuilder: (context, index) {
                final skillIndex = index % skills.length;
                final skill = skills[skillIndex];
                final isActive = _currentPage == skillIndex;

                return AnimatedScale(
                  scale: isActive ? 1.0 : 0.85,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                  child: AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.5,
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F1822) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isActive
                              ? (isDark
                                        ? AppColors.primaryLight
                                        : AppColors.primaryDark)
                                    .withOpacity(0.4)
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isActive
                                ? (isDark
                                          ? AppColors.primaryLight
                                          : AppColors.primaryDark)
                                      .withOpacity(0.2)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: isActive ? 30 : 10,
                            offset: Offset(0, isActive ? 15 : 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Semantics(
                          label: skill.label,
                          child: Image.asset(
                            skill.assetPath,
                            width: 140,
                            height: 140,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.code_rounded,
                                size: 100,
                                color:
                                    (isDark
                                            ? AppColors.primaryLight
                                            : AppColors.primaryDark)
                                        .withOpacity(0.5),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Pagination dots
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
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                : (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                      .withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  // Desktop: Horizontal auto-scrolling row with hover effects
  Widget _buildDesktopGrid(BuildContext context) {
    final skills = SkillData.getAllSkills();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 320,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _pauseDesktopScroll();
          } else if (notification is ScrollEndNotification) {
            _resumeDesktopScroll();
          }
          return false;
        },
        child: ListView.builder(
          controller: _desktopScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: skills.length * 100, // Infinite scroll
          itemBuilder: (context, index) {
            final skillIndex = index % skills.length;
            final skill = skills[skillIndex];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: _SkillCardHover(
                skill: skill,
                isDark: isDark,
                onHoverStart: _pauseDesktopScroll,
                onHoverEnd: _resumeDesktopScroll,
              ),
            );
          },
        ),
      ),
    );
  }
}

// Separate StatefulWidget for hover effect on desktop
class _SkillCardHover extends StatefulWidget {
  final SkillModel skill;
  final bool isDark;
  final VoidCallback? onHoverStart;
  final VoidCallback? onHoverEnd;

  const _SkillCardHover({
    required this.skill,
    required this.isDark,
    this.onHoverStart,
    this.onHoverEnd,
  });

  @override
  State<_SkillCardHover> createState() => _SkillCardHoverState();
}

class _SkillCardHoverState extends State<_SkillCardHover>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _elevationAnimation = Tween<double>(begin: 0, end: 25).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
        widget.onHoverStart?.call();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
        widget.onHoverEnd?.call();
      },
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: widget.isDark ? const Color(0xFF0F1822) : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _isHovered
                      ? (widget.isDark
                                ? AppColors.primaryLight
                                : AppColors.primaryDark)
                            .withOpacity(0.6)
                      : (widget.isDark
                                ? AppColors.primaryLight
                                : AppColors.primaryDark)
                            .withOpacity(0.2),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? (widget.isDark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark)
                              .withOpacity(0.3)
                        : Colors.black.withOpacity(0.08),
                    blurRadius: _elevationAnimation.value + 15,
                    offset: Offset(0, _elevationAnimation.value / 2),
                    spreadRadius: _isHovered ? 2 : 0,
                  ),
                ],
              ),
              child: Center(
                child: Semantics(
                  label: widget.skill.label,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: Matrix4.identity()
                      ..rotateZ(_isHovered ? 0.05 : 0),
                    child: Image.asset(
                      widget.skill.assetPath,
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.code_rounded,
                          size: 100,
                          color:
                              (widget.isDark
                                      ? AppColors.primaryLight
                                      : AppColors.primaryDark)
                                  .withOpacity(0.5),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
