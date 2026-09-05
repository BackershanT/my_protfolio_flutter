import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';
import 'package:my_protfolio/features/technologies/data/models/technology_model.dart';
import 'package:my_protfolio/features/admin/data/providers/skill_provider.dart';
import 'package:my_protfolio/features/technologies/presentation/widgets/connection_line_painter.dart';
import 'package:my_protfolio/features/technologies/presentation/widgets/tech_icon_widget.dart';
import 'package:my_protfolio/features/technologies/presentation/widgets/tech_image_helper.dart';
import 'dart:math' as math;

class TechOrbitCircleWidget extends StatefulWidget {
  final TechnologySection section;
  final AnimationController rotationController;
  final bool isMobile;

  const TechOrbitCircleWidget({
    super.key,
    required this.section,
    required this.rotationController,
    required this.isMobile,
  });

  @override
  State<TechOrbitCircleWidget> createState() => _TechOrbitCircleWidgetState();
}

class _TechOrbitCircleWidgetState extends State<TechOrbitCircleWidget> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;
    final skills = context.watch<SkillProvider>().skills;

    final centerAsset = TechImageHelper.resolveImagePath(
      widget.section.name,
      widget.section.centerAsset,
      skills,
    );
    final technologies = widget.section.technologies;

    final radius = widget.isMobile ? 120.0 : (isTablet ? 140.0 : 180.0);
    final iconSize = widget.isMobile ? 50.0 : (isTablet ? 55.0 : 60.0);
    final centerIconSize = widget.isMobile ? 90.0 : (isTablet ? 100.0 : 120.0);

    return RepaintBoundary(
      child: SizedBox(
        height: radius * 2.5,
        width: radius * 2.5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            FloatingWidget(
              amplitude: 12,
              duration: const Duration(seconds: 4),
              child: TiltCard(
                maxTilt: 18,
                scale: 1.0,
                glareOpacity: 0.18,
                borderRadius: BorderRadius.circular(500),
                child: Container(
                  width: centerIconSize,
                  height: centerIconSize,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.primaryLight.withValues(alpha: 0.08)
                        : AppColors.primaryDark.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.primaryLight
                          : AppColors.primaryDark,
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.primaryLight
                                : AppColors.primaryDark)
                            .withValues(alpha: 0.45),
                        blurRadius: 40,
                        spreadRadius: 6,
                      ),
                      BoxShadow(
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.primaryLight
                                : AppColors.primaryDark)
                            .withValues(alpha: 0.15),
                        blurRadius: 80,
                        spreadRadius: 16,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: TechImageHelper.buildDynamicImage(
                      centerAsset,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.flutter_dash,
                        size: centerIconSize * 0.6,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.primaryLight
                            : AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
              ),
            ).animate().scale(
              delay: 200.ms,
              duration: 800.ms,
              curve: Curves.elasticOut,
            ),
            ...List.generate(technologies.length, (index) {
              final angle = (2 * math.pi / technologies.length) * index;

              return AnimatedBuilder(
                animation: widget.rotationController,
                builder: (context, child) {
                  final rotationAngle = widget.rotationController.value * 2 * math.pi;
                  final newX = radius * math.cos(angle + rotationAngle);
                  final newY = radius * math.sin(angle + rotationAngle);

                  return Transform.translate(
                    offset: Offset(newX, newY),
                    child: child,
                  );
                },
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = -1),
                  child: TechIconWidget(
                    tech: technologies[index],
                    index: index,
                    size: iconSize,
                    isHovered: _hoveredIndex == index,
                  ),
                ),
              );
            }),
            ...List.generate(technologies.length, (index) {
              return AnimatedBuilder(
                animation: widget.rotationController,
                builder: (context, child) {
                  final angle =
                      (2 * math.pi / technologies.length) * index +
                      widget.rotationController.value * 2 * math.pi;
                  return CustomPaint(
                    size: Size(radius * 2, radius * 2),
                    painter: ConnectionLinePainter(
                      angle: angle,
                      radius: radius,
                      color:
                          (Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark)
                              .withValues(alpha: 0.2),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
