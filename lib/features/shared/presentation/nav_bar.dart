import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
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
            Row(
              children: [
                if (Responsive.isDesktop(context))
                  ResponsiveNavigation(
                    onNavTap: widget.onNavTap,
                    currentIndex: widget.currentIndex,
                  ),
                const SizedBox(width: 10),
                // Premium Language Selection Box
                PopupMenuButton<Locale>(
                  icon: Icon(
                    Icons.language,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.primaryLight
                        : AppColors.primaryDark,
                  ),
                  tooltip: 'Change Language',
                  offset: const Offset(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Theme.of(context).cardColor,
                  onSelected: (Locale locale) {
                    if (context.locale != locale) {
                      context.setLocale(locale);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: const Locale('en'),
                      child: Row(
                        children: [
                          const Text('🇺🇸', style: TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Text(
                            'English',
                            style: TextStyle(
                              color: context.locale.languageCode == 'en'
                                  ? (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.primaryLight
                                        : AppColors.primaryDark)
                                  : null,
                              fontWeight: context.locale.languageCode == 'en'
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                          if (context.locale.languageCode == 'en') ...[
                            const Spacer(),
                            Icon(
                              Icons.check,
                              size: 18,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark,
                            ),
                          ],
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: const Locale('ar'),
                      child: Row(
                        children: [
                          const Text('🇸🇦', style: TextStyle(fontSize: 20)),
                          const SizedBox(width: 12),
                          Text(
                            'العربية',
                            style: TextStyle(
                              color: context.locale.languageCode == 'ar'
                                  ? (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.primaryLight
                                        : AppColors.primaryDark)
                                  : null,
                              fontWeight: context.locale.languageCode == 'ar'
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                          if (context.locale.languageCode == 'ar') ...[
                            const Spacer(),
                            Icon(
                              Icons.check,
                              size: 18,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (!Responsive.isDesktop(context))
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.primaryLight
                          : AppColors.primaryDark,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
              ],
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
