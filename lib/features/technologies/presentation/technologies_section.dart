import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/utils/responsive.dart';
import 'package:my_protfolio/core/presentation/widgets/section_title.dart';
import 'package:my_protfolio/features/technologies/data/models/technology_model.dart';
import 'package:my_protfolio/features/admin/data/providers/skill_provider.dart';
import 'package:my_protfolio/features/technologies/presentation/widgets/tech_orbit_circle_widget.dart';
import 'package:my_protfolio/features/technologies/presentation/widgets/tech_text_content_widget.dart';

class TechnologiesSection extends StatefulWidget {
  const TechnologiesSection({super.key});

  @override
  State<TechnologiesSection> createState() => _TechnologiesSectionState();
}

class _TechnologiesSectionState extends State<TechnologiesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SkillProvider>().loadSkills();
      }
    });
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
        TechOrbitCircleWidget(
          section: section,
          rotationController: _rotationController,
          isMobile: true,
        ),
        const SizedBox(height: 60),
        TechTextContentWidget(
          subtitle: section.subtitle,
          headline: section.headline,
          description: section.description,
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
        child: TechOrbitCircleWidget(
          section: section,
          rotationController: _rotationController,
          isMobile: false,
        ),
      ),
    );

    final textWidget = Expanded(
      flex: 3,
      child: TechTextContentWidget(
        subtitle: section.subtitle,
        headline: section.headline,
        description: section.description,
      ),
    );

    final bool showIconOnLeft = isFirst || section.name.contains('MERN');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: showIconOnLeft
          ? [iconWidget, SizedBox(width: spacing), textWidget]
          : [textWidget, SizedBox(width: spacing), iconWidget],
    );
  }
}
