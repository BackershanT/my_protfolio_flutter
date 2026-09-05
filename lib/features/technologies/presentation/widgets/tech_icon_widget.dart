import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/technologies/data/models/technology_model.dart';
import 'package:my_protfolio/features/admin/data/providers/skill_provider.dart';
import 'package:my_protfolio/features/technologies/presentation/widgets/tech_image_helper.dart';

class TechIconWidget extends StatelessWidget {
  final TechnologyModel tech;
  final int index;
  final double size;
  final bool isHovered;

  const TechIconWidget({
    super.key,
    required this.tech,
    required this.index,
    required this.size,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final skills = context.watch<SkillProvider>().skills;
    final resolvedTechPath = TechImageHelper.resolveImagePath(tech.name, tech.assetPath, skills);

    final iconWidget = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: isHovered ? size * 1.22 : size,
      height: isHovered ? size * 1.22 : size,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: isHovered
              ? tech.color
              : (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
          width: isHovered ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? tech.color.withValues(alpha: 0.55)
                : Colors.black.withValues(alpha: 0.12),
            blurRadius: isHovered ? 28 : 10,
            spreadRadius: isHovered ? 4 : 0,
          ),
          if (isHovered)
            BoxShadow(
              color: tech.color.withValues(alpha: 0.20),
              blurRadius: 50,
              spreadRadius: 10,
            ),
        ],
      ),
      child: ClipOval(
        child: resolvedTechPath.isNotEmpty
            ? Padding(
                padding: EdgeInsets.all(size * 0.22),
                child: TechImageHelper.buildDynamicImage(
                  resolvedTechPath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    tech.iconData ?? Icons.code_rounded,
                    size: size * 0.5,
                    color: isHovered ? tech.color : tech.color.withValues(alpha: 0.7),
                  ),
                ),
              )
            : Icon(
                tech.iconData ?? Icons.code_rounded,
                size: size * 0.5,
                color: isHovered ? tech.color : tech.color.withValues(alpha: 0.7),
              ),
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        iconWidget,
        if (isHovered)
          Positioned(
            bottom: -(size * 0.55),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: tech.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: tech.color.withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                tech.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().fadeIn(duration: 150.ms).scale(
              begin: const Offset(0.8, 0.8),
              duration: 150.ms,
              curve: Curves.easeOutBack,
            ),
          ),
      ],
    );
  }
}
