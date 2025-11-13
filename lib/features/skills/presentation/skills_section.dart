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

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _autoScrollController;
  int _centerIndex = 0;
  final double _cardWidth = 280.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _autoScrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _startAutoScroll();
      }
    });

    _scrollController.addListener(_updateCenterIndex);
  }

  void _startAutoScroll() {
    if (!_scrollController.hasClients) {
      // Wait for the controller to be attached
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _scrollController.hasClients) {
          _startAutoScroll();
        }
      });
      return;
    }
    
    final maxScroll = _scrollController.position.maxScrollExtent;
    final startPosition = _scrollController.offset;

    _autoScrollController.addListener(() {
      if (_scrollController.hasClients) {
        final offset = startPosition +
            (maxScroll - startPosition) * _autoScrollController.value;
        _scrollController.jumpTo(offset);
      }
    });

    _autoScrollController.repeat();
  }

  void _updateCenterIndex() {
    if (!_scrollController.hasClients) return;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final centerPosition = _scrollController.offset + (screenWidth / 2);
    final newIndex = (centerPosition / _cardWidth).round();
    
    if (newIndex != _centerIndex && newIndex >= 0) {
      setState(() {
        _centerIndex = newIndex % SkillData.getAllSkills().length;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateCenterIndex);
    _scrollController.dispose();
    _autoScrollController.dispose();
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
          SizedBox(height: screenWidth < 850 ? 40 : 50),
          Responsive(
            mobile: _buildMobileLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildScrollingRow(context, isMobile: true);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return _buildScrollingRow(context, isMobile: false);
  }

  Widget _buildScrollingRow(BuildContext context, {required bool isMobile}) {
    final skillIcons = SkillData.getAllSkills();
    
    return SizedBox(
      height: isMobile ? 240 : 320,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _autoScrollController.stop();
          } else if (notification is ScrollEndNotification) {
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted && !_scrollController.position.isScrollingNotifier.value) {
                _autoScrollController.repeat();
              }
            });
          }
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: skillIcons.length * 100,
          itemBuilder: (context, index) {
            final skillIndex = index % skillIcons.length;
            final isCentered = _centerIndex == skillIndex;
            
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 24,
                vertical: isMobile ? 20 : 20,
              ),
              child: _buildSkillCard(
                context,
                skillIcons[skillIndex],
                skillIndex,
                isMobile: isMobile,
                isCentered: isCentered,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSkillCard(
    BuildContext context,
    SkillModel skill,
    int index, {
    required bool isMobile,
    required bool isCentered,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AnimatedScale(
      scale: isCentered ? 1.0 : 0.85,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: isCentered ? 1.0 : 0.4,
        duration: const Duration(milliseconds: 600),
        child: Container(
          width: isMobile ? 200 : 280,
          height: isMobile ? 200 : 280,
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF0F1822)
                : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isCentered
                  ? (isDark ? AppColors.primaryLight : AppColors.primaryDark).withOpacity(0.3)
                  : Colors.transparent,
              width: 2,
            ),
            boxShadow: isCentered
                ? [
                    BoxShadow(
                      color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                          .withOpacity(0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Center(
            child: Container(
              width: isMobile ? 120 : 160,
              height: isMobile ? 120 : 160,
              child: Image.asset(
                skill.assetPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.code_rounded,
                    size: isMobile ? 80 : 100,
                    color: (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                        .withOpacity(0.5),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}