import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/technologies/data/models/technology_model.dart';
import 'dart:math' as math;

class TechnologiesSection extends StatefulWidget {
  const TechnologiesSection({super.key});

  @override
  State<TechnologiesSection> createState() => _TechnologiesSectionState();
}

class _TechnologiesSectionState extends State<TechnologiesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final sections = TechnologyData.getAllSections();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth < 850 ? 20 : (screenWidth < 1200 ? 40 : 100),
        vertical: screenWidth < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: AppTexts.technologiesTitle),
          SizedBox(height: screenWidth < 850 ? 60 : 80),
          ...List.generate(
            sections.length,
            (index) => Column(
              children: [
                _buildTechnologySubsection(
                  context,
                  sections[index],
                  isFirst: index == 0,
                ),
                if (index < sections.length - 1)
                  SizedBox(height: screenWidth < 850 ? 80 : 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologySubsection(
    BuildContext context,
    TechnologySection section, {
    required bool isFirst,
  }) {
    return Responsive(
      mobile: _buildMobileLayout(context, section),
      desktop: _buildDesktopLayout(context, section, isFirst: isFirst),
    );
  }

  Widget _buildMobileLayout(BuildContext context, TechnologySection section) {
    return Column(
      children: [
        _buildIconCircle(
          context,
          section.centerAsset,
          section.technologies,
          isMobile: true,
        ),
        const SizedBox(height: 60),
        _buildTextContent(
          context,
          section.subtitle,
          section.headline,
          section.description,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    TechnologySection section, {
    required bool isFirst,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;
    final isLargeDesktop = screenWidth >= 1400;

    final spacing = isTablet ? 30.0 : (isLargeDesktop ? 80.0 : 60.0);
    final flexRatio = isTablet ? 1 : 2;

    final iconWidget = Flexible(
      flex: flexRatio,
      child: Center(
        child: _buildIconCircle(
          context,
          section.centerAsset,
          section.technologies,
          isMobile: false,
        ),
      ),
    );

    final textWidget = Expanded(
      flex: 3,
      child: _buildTextContent(
        context,
        section.subtitle,
        section.headline,
        section.description,
      ),
    );

    // Determine layout order: Flutter and MERN sections show icon on left, React shows text on left
    final bool showIconOnLeft = isFirst || section.name.contains('MERN');
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: showIconOnLeft
          ? [iconWidget, SizedBox(width: spacing), textWidget]
          : [textWidget, SizedBox(width: spacing), iconWidget],
    );
  }

  Widget _buildTextContent(
    BuildContext context,
    String subtitle,
    String headline,
    String description,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    final smallTitleSize = isMobile ? 14.0 : (isTablet ? 15.0 : 16.0);
    final headlineSize = isMobile ? 24.0 : (isTablet ? 32.0 : 42.0);
    final bodySize = isMobile ? 14.0 : (isTablet ? 16.0 : 18.0);
    final titleSpacing = isMobile ? 15.0 : 20.0;
    final headlineSpacing = isMobile ? 16.0 : (isTablet ? 20.0 : 24.0);

    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          subtitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.primaryLight
                : AppColors.primaryDark,
            fontSize: smallTitleSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
        SizedBox(height: titleSpacing),
        Text(
              headline,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: headlineSize,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors
                          .primaryLight // Cyan color for dark mode
                    : null, // Use default color for light mode
              ),
              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slide(
              begin: const Offset(0, 0.2),
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        SizedBox(height: headlineSpacing),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: bodySize,
            height: 1.7,
            color: Theme.of(
              context,
            ).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
          ),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildIconCircle(
    BuildContext context,
    String centerAsset,
    List<TechnologyModel> technologies, {
    required bool isMobile,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;

    // Responsive sizing
    final radius = isMobile ? 120.0 : (isTablet ? 140.0 : 180.0);
    final iconSize = isMobile ? 50.0 : (isTablet ? 55.0 : 60.0);
    final centerIconSize = isMobile ? 90.0 : (isTablet ? 100.0 : 120.0);

    return SizedBox(
      height: radius * 2.5,
      width: radius * 2.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center logo (Flutter or React)
          Container(
            width: centerIconSize,
            height: centerIconSize,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.primaryLight.withValues(alpha: 0.1)
                  : AppColors.primaryDark.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : AppColors.primaryDark,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      (Theme.of(context).brightness == Brightness.dark
                              ? AppColors.primaryLight
                              : AppColors.primaryDark)
                          .withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                centerAsset,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.flutter_dash,
                    size: centerIconSize * 0.6,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.primaryLight
                        : AppColors.primaryDark,
                  );
                },
              ),
            ),
          ).animate().scale(
            delay: 200.ms,
            duration: 800.ms,
            curve: Curves.elasticOut,
          ),
          // Surrounding tech icons
          ...List.generate(technologies.length, (index) {
            final angle = (2 * math.pi / technologies.length) * index;
            final x = radius * math.cos(angle);
            final y = radius * math.sin(angle);

            return AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                final rotationAngle = _rotationController.value * 2 * math.pi;
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
                child: _buildTechIcon(
                  context,
                  technologies[index],
                  index,
                  iconSize,
                ),
              ),
            );
          }),
          // Connection lines
          ...List.generate(technologies.length, (index) {
            return AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                final angle =
                    (2 * math.pi / technologies.length) * index +
                    _rotationController.value * 2 * math.pi;
                return CustomPaint(
                  size: Size(radius * 2, radius * 2),
                  painter: _ConnectionLinePainter(
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
    );
  }

  Widget _buildTechIcon(
    BuildContext context,
    TechnologyModel tech,
    int index,
    double size,
  ) {
    final isHovered = _hoveredIndex == index;

    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isHovered
                  ? tech.color
                  : (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withValues(alpha: 0.1),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? tech.color.withValues(alpha: 0.4)
                    : Colors.black.withValues(alpha: 0.1),
                blurRadius: isHovered ? 15 : 10,
                spreadRadius: isHovered ? 2 : 0,
              ),
            ],
          ),
          child: tech.assetPath != null
              ? Padding(
                  padding: EdgeInsets.all(size * 0.25),
                  child: Image.asset(
                    tech.assetPath!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        tech.iconData ?? Icons.code_rounded,
                        size: size * 0.5,
                        color: isHovered
                            ? tech.color
                            : tech.color.withValues(alpha: 0.7),
                      );
                    },
                  ),
                )
              : Icon(
                  tech.iconData ?? Icons.code_rounded,
                  size: size * 0.5,
                  color: isHovered
                      ? tech.color
                      : tech.color.withValues(alpha: 0.7),
                ),
        )
        .animate(target: isHovered ? 1 : 0)
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.2, 1.2),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }
}

class _ConnectionLinePainter extends CustomPainter {
  final double angle;
  final double radius;
  final Color color;

  _ConnectionLinePainter({
    required this.angle,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final endPoint = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    canvas.drawLine(center, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant _ConnectionLinePainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
