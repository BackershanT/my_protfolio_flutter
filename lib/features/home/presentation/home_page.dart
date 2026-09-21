import 'package:flutter/material.dart';
import 'package:my_protfolio/features/hero/presentation/hero_section.dart';
import 'package:my_protfolio/features/about/presentation/about_section.dart';
import 'package:my_protfolio/features/skills/presentation/skills_section.dart';
import 'package:my_protfolio/features/technologies/presentation/technologies_section.dart';
import 'package:my_protfolio/features/projects/presentation/projects_section.dart';
import 'package:my_protfolio/features/blog/presentation/blog_section.dart';
import 'package:my_protfolio/features/contact/presentation/contact_section.dart';
import 'package:my_protfolio/features/home/presentation/footer_section.dart';
import 'package:my_protfolio/core/presentation/widgets/nav_bar.dart';
import 'package:my_protfolio/features/testimonials/presentation/testimonials_section.dart';
import 'package:my_protfolio/core/presentation/widgets/custom_cursor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/constants/app_assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late final List<GlobalKey> _sectionKeys;

  int _currentIndex = 0;
  bool _isDarkMode = false;
  bool _showScrollToTop = false;
  double _lastCheckedScrollPosition = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (_isDarkMode != isDark) {
      setState(() {
        _isDarkMode = isDark;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _sectionKeys = List.generate(8, (index) => GlobalKey());
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
    final scrollPosition = _scrollController.position.pixels;
    final screenHeight = _scrollController.position.viewportDimension;

    // Show/hide scroll to top button
    if (scrollPosition > 300 && !_showScrollToTop) {
      setState(() {
        _showScrollToTop = true;
      });
    } else if (scrollPosition <= 300 && _showScrollToTop) {
      setState(() {
        _showScrollToTop = false;
      });
    }

    // Throttle section visibility calculation to avoid heavy tree traversals on every pixel
    if ((scrollPosition - _lastCheckedScrollPosition).abs() < 30) {
      return;
    }
    _lastCheckedScrollPosition = scrollPosition;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final ctx = key.currentContext;
      if (ctx != null && ctx.mounted) {
        final renderObject = ctx.findRenderObject();
        if (renderObject is RenderBox && renderObject.attached && renderObject.hasSize) {
          try {
            final position = renderObject.localToGlobal(Offset.zero);
            final sectionTop = position.dy;
            final sectionBottom = sectionTop + renderObject.size.height;

            if (sectionTop <= screenHeight / 2 &&
                sectionBottom >= screenHeight / 2) {
              if (_currentIndex != i) {
                setState(() {
                  _currentIndex = i;
                });
              }
              break;
            }
          } catch (_) {
            // Ignore temporary paint/layout detachment assertions during web scroll animations
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    if (index >= 0 && index < _sectionKeys.length) {
      final key = _sectionKeys[index];
      final ctx = key.currentContext;
      if (ctx != null && ctx.mounted) {
        final renderObj = ctx.findRenderObject();
        if (renderObj != null && renderObj.attached) {
          Scrollable.ensureVisible(
            ctx,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _buildEndDrawer(),
      body: CustomCursor(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          switchInCurve: Curves.easeInQuad,
          switchOutCurve: Curves.easeOutQuad,
          child: Stack(
            key: ValueKey(context.locale.languageCode),
            children: [
              Column(
                children: [
                  NavBar(
                    onNavTap: (index) {
                      _scrollToSection(index);
                    },
                    currentIndex: _currentIndex,
                  ).withCursorHover(context),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          HeroSection(
                            key: _sectionKeys[0],
                            onViewProjects: () => _scrollToSection(4),
                          ),
                          AboutSection(key: _sectionKeys[1]),
                          SkillsSection(key: _sectionKeys[2]),
                          TechnologiesSection(key: _sectionKeys[3]),
                          ProjectsSection(key: _sectionKeys[4]),
                          TestimonialsSection(key: _sectionKeys[5]),
                          BlogSection(key: _sectionKeys[6]),
                          ContactSection(key: _sectionKeys[7]),
                          const FooterSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Scroll to top button
              if (_showScrollToTop)
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: FloatingActionButton(
                    onPressed: () {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                      );
                    },
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                        ? AppColors.primaryLight
                        : AppColors.primaryDark,
                    child: Icon(
                      Icons.arrow_upward,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkBackground
                          : Colors.white,
                    ),
                  ).withCursorHover(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEndDrawer() {
    final navItems = [
      AppTexts.navHome,
      AppTexts.navAbout,
      AppTexts.navSkills,
      AppTexts.navTechnologies,
      AppTexts.navProjects,
      AppTexts.navTestimonials,
      AppTexts.navBlog,
      AppTexts.navContact,
    ];

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            // Drawer header with profile avatar
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile avatar
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(AppAssets.profileAvatar),
                  ),
                  // Name and close button
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        AppTexts.heroName,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.primaryLight
                          : AppColors.primaryDark,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            // Navigation items
            Expanded(
              child: ListView.builder(
                itemCount: navItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      navItems[index],
                      style: TextStyle(
                        color: _currentIndex == index
                            ? (Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark)
                            : Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: _currentIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      _scrollToSection(index);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
