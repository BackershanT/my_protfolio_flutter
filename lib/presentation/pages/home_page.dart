import 'package:flutter/material.dart';
import 'package:my_protfolio/features/hero/presentation/hero_section.dart';
import 'package:my_protfolio/features/about/presentation/about_section.dart';
import 'package:my_protfolio/features/skills/presentation/skills_section.dart';
import 'package:my_protfolio/features/projects/presentation/projects_section.dart';
import 'package:my_protfolio/features/contact/presentation/contact_section.dart';
import 'package:my_protfolio/features/shared/presentation/footer_section.dart';
import 'package:my_protfolio/features/shared/presentation/nav_bar.dart';
import 'package:my_protfolio/features/shared/presentation/testimonials_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(7, (index) => GlobalKey());
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Determine which section is currently visible
    final screenHeight = _scrollController.position.viewportDimension;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      if (key.currentContext != null) {
        final RenderBox renderBox =
            key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final sectionTop = position.dy;
        final sectionBottom = sectionTop + renderBox.size.height;

        if (sectionTop <= screenHeight / 2 && sectionBottom >= screenHeight / 2) {
          if (_currentIndex != i) {
            setState(() {
              _currentIndex = i;
            });
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    if (index >= 0 && index < _sectionKeys.length) {
      final key = _sectionKeys[index];
      if (key.currentContext != null) {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(
            onNavTap: _scrollToSection,
            currentIndex: _currentIndex,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(key: _sectionKeys[0]),
                  AboutSection(key: _sectionKeys[1]),
                  SkillsSection(key: _sectionKeys[2]),
                  ProjectsSection(key: _sectionKeys[3]),
                  TestimonialsSection(key: _sectionKeys[4]),
                  ContactSection(key: _sectionKeys[5]),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}