import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/theme/app_theme.dart';
import 'package:my_protfolio/features/shared/core/utils/theme_helper.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final Function(int) onNavTap;
  final int currentIndex;

  const NavBar({super.key, required this.onNavTap, required this.currentIndex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo/Name
            Text(
              AppTexts.heroName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : AppColors.primaryDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Navigation Items (Responsive)
            if (Responsive.isDesktop(context))
              Expanded(
                child: ResponsiveNavigation(
                  onNavTap: widget.onNavTap,
                  currentIndex: widget.currentIndex,
                ),
              )
            else
              // Hamburger menu for mobile and tablet
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.primaryLight
                      : AppColors.primaryDark,
                ),
                onPressed: () {
                  // Open the end drawer
                  Scaffold.of(context).openEndDrawer();
                },
              ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveNavigation extends StatelessWidget {
  final Function(int) onNavTap;
  final int currentIndex;

  const ResponsiveNavigation({
    super.key,
    required this.onNavTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      AppTexts.navHome,
      AppTexts.navAbout,
      AppTexts.navSkills,
      AppTexts.navTechnologies,
      AppTexts.navProjects,
      AppTexts.navProfiles,
      AppTexts.navTestimonials,
      AppTexts.navBlog,
      AppTexts.navContact,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if all items fit in a row
        final totalWidth =
            navItems.length * 100.0; // Approximate width per item
        if (totalWidth < constraints.maxWidth) {
          // Items fit in a row
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              navItems.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextButton(
                  onPressed: () => onNavTap(index),
                  child: Text(
                    navItems[index],
                    style: TextStyle(
                      color: currentIndex == index
                          ? (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.primaryLight
                                : AppColors.primaryDark)
                          : Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: currentIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          // Items don't fit, use a dropdown or scrollable
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                navItems.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextButton(
                    onPressed: () => onNavTap(index),
                    child: Text(
                      navItems[index],
                      style: TextStyle(
                        color: currentIndex == index
                            ? (Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark)
                            : Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: currentIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
