import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';

class SkillCardWidget extends StatefulWidget {
  final SkillModel skill;
  final bool isDark;
  final bool isActive;
  final bool isMobile;

  const SkillCardWidget({
    super.key,
    required this.skill,
    required this.isDark,
    required this.isActive,
    required this.isMobile,
  });

  @override
  State<SkillCardWidget> createState() => _SkillCardWidgetState();
}

class _SkillCardWidgetState extends State<SkillCardWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isDark ? AppColors.primaryLight : AppColors.primaryDark;
    final isHighlighted = widget.isActive || _isHovered;

    // Card dimensions
    final cardWidth = widget.isMobile ? 220.0 : 200.0;
    final cardHeight = widget.isMobile ? 220.0 : 200.0;
    final iconSize = widget.isMobile ? 90.0 : 80.0;

    // Build the inner content of the card
    Widget cardContent = Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: widget.isDark
            ? (isHighlighted ? const Color(0xFF162545) : const Color(0xFF0F172A).withValues(alpha: 0.7))
            : (isHighlighted ? Colors.white : Colors.grey.shade50),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glowing orb on hover
          AnimatedOpacity(
            opacity: isHighlighted ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutQuart,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    primaryColor.withValues(alpha: widget.isDark ? 0.3 : 0.15),
                    Colors.transparent,
                  ],
                  stops: const [0.2, 1.0],
                ),
              ),
            ),
          ),
          
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with Hero and animations
              Hero(
                tag: 'skill_${widget.skill.name}_${widget.isMobile}_${widget.isActive}',
                child: widget.skill.image.startsWith('http')
                    ? Image.network(
                        widget.skill.image,
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.code,
                          size: 60,
                          color: primaryColor.withValues(alpha: 0.5),
                        ),
                      )
                    : Image.asset(
                        widget.skill.image,
                        width: iconSize,
                        height: iconSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.code,
                          size: 60,
                          color: primaryColor.withValues(alpha: 0.5),
                        ),
                      ),
              )
                  .animate(target: isHighlighted ? 1 : 0)
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1.1, 1.1),
                    duration: 500.ms,
                    curve: Curves.easeOutBack,
                  )
                  .shimmer(
                    duration: 1500.ms,
                    color: primaryColor.withValues(alpha: 0.4),
                    blendMode: BlendMode.srcATop,
                  ),
                  
              const SizedBox(height: 20),
              
              // Text label
              Text(
                widget.skill.name,
                style: TextStyle(
                  fontSize: widget.isMobile ? 18 : 16,
                  fontWeight: FontWeight.w700,
                  color: widget.isDark ? Colors.white : AppColors.primaryDark,
                  letterSpacing: 1.2,
                ),
              )
                  .animate(target: isHighlighted ? 1 : 0)
                  .tint(color: primaryColor, begin: 0, end: widget.isDark ? 0.8 : 0.2)
                  .slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOutQuart),
            ],
          ),
        ],
      ),
    );

    // Apply glassmorphism if dark mode
    if (widget.isDark) {
      cardContent = ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: cardContent,
        ),
      );
    }

    // Wrap with gradient border container
    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(2), // Gradient border width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isHighlighted
              ? [
                  primaryColor.withValues(alpha: 0.8),
                  primaryColor.withValues(alpha: 0.2),
                  primaryColor.withValues(alpha: 0.8),
                ]
              : [
                  widget.isDark ? Colors.white12 : Colors.black12,
                  Colors.transparent,
                  widget.isDark ? Colors.white12 : Colors.black12,
                ],
          stops: const [0.0, 0.5, 1.0],
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.3),
                  blurRadius: 40,
                  offset: const Offset(0, 15),
                  spreadRadius: 2,
                )
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: cardContent,
    );

    // Add interactivity and 3D effects
    if (!widget.isMobile) {
      return TiltCard(
        maxTilt: 20,
        scale: isHighlighted ? 1.05 : 1.0,
        glareOpacity: widget.isDark ? 0.15 : 0.0,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: card,
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: isHighlighted ? 1.05 : 0.95,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        child: card,
      ),
    );
  }
}
