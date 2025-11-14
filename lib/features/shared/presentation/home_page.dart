import 'package:flutter/material.dart';
import 'package:my_protfolio/features/hero/presentation/hero_section.dart';
import 'package:my_protfolio/features/about/presentation/about_section.dart';
import 'package:my_protfolio/features/skills/presentation/skills_section.dart';
import 'package:my_protfolio/features/technologies/presentation/technologies_section.dart';
import 'package:my_protfolio/features/projects/presentation/projects_section.dart';
import 'package:my_protfolio/features/blog/presentation/blog_section.dart';
import 'package:my_protfolio/features/contact/presentation/contact_section.dart';
import 'package:my_protfolio/features/shared/presentation/footer_section.dart';
import 'package:my_protfolio/features/shared/presentation/nav_bar.dart';
import 'package:my_protfolio/features/shared/presentation/testimonials_section.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/shared/core/theme/app_theme.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(9, (index) => GlobalKey());
  int _currentIndex = 0;
  late AnimationController _chainController;
  late Animation<double> _chainAnimation;
  bool _isDarkMode = false;
  bool _showScrollToTop = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the theme state based on the current theme mode
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    setState(() {
      _isDarkMode =
          themeProvider.themeMode == ThemeMode.dark ||
          (themeProvider.themeMode == ThemeMode.system &&
              MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // Initialize animation controller for the chain
    _chainController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _chainAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _chainController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _chainController.dispose();
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

    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      if (key.currentContext != null) {
        final RenderBox renderBox =
            key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final sectionTop = position.dy;
        final sectionBottom = sectionTop + renderBox.size.height;

        if (sectionTop <= screenHeight / 2 &&
            sectionBottom >= screenHeight / 2) {
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

  void _toggleTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    // Animate the chain pull
    if (_chainController.isCompleted) {
      _chainController.reverse();
    } else {
      _chainController.forward();
    }

    // Toggle theme after a short delay to simulate the pull action
    Future.delayed(const Duration(milliseconds: 300), () {
      final newThemeMode = !_isDarkMode;
      themeProvider.toggleTheme(newThemeMode);
      setState(() {
        _isDarkMode = newThemeMode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _buildEndDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              NavBar(onNavTap: _scrollToSection, currentIndex: _currentIndex),
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
          // Light bulb pull chain mechanism
          Positioned(top: 100, right: 20, child: _buildLightBulbChain()),
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
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : AppColors.primaryDark,
                child: Icon(
                  Icons.arrow_upward,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkBackground
                      : Colors.white,
                ),
              ),
            ),
        ],
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

  Widget _buildLightBulbChain() {
    return GestureDetector(
      onTap: _toggleTheme,
      child: Column(
        children: [
          // Light bulb
          Icon(
            Icons.lightbulb,
            size: 40,
            color: _isDarkMode ? Colors.amber : Colors.grey,
          ),
          // Chain with zigzag needle
          AnimatedBuilder(
            animation: _chainAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 30 * _chainAnimation.value),
                child: CustomPaint(
                  size: const Size(20, 80),
                  painter: ZigzagChainPainter(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ZigzagChainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Draw the chain line
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height - 20);

    // Draw the zigzag needle at the bottom
    final needleY = size.height - 20;
    path.moveTo(size.width / 2, needleY);
    path.lineTo(size.width / 2 - 5, needleY + 5);
    path.lineTo(size.width / 2 + 5, needleY + 10);
    path.lineTo(size.width / 2 - 5, needleY + 15);
    path.lineTo(size.width / 2 + 5, needleY + 20);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
