import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_protfolio/core/presentation/widgets/custom_cursor.dart';
import 'package:my_protfolio/features/admin/presentation/pages/admin_testimonials_page.dart';
import 'package:my_protfolio/features/admin/presentation/pages/admin_skills_page.dart';
import 'package:my_protfolio/features/admin/presentation/pages/admin_blogs_page.dart';
import 'package:my_protfolio/features/admin/presentation/pages/admin_projects_page.dart';
import 'package:my_protfolio/features/admin/presentation/pages/admin_messages_page.dart';
import 'package:my_protfolio/features/admin/presentation/pages/admin_about_page.dart';
import 'package:my_protfolio/features/admin/presentation/pages/admin_translations_page.dart';

class AdminLayout extends StatefulWidget {
  final Widget? child; // The active dashboard content
  const AdminLayout({super.key, this.child});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int _selectedIndex = 0;
  bool _isRailExtended = true;

  static const List<_NavItem> _navItems = [
    _NavItem(title: 'Projects', icon: Icons.work_outlined, selectedIcon: Icons.work),
    _NavItem(title: 'Testimonials', icon: Icons.format_quote_outlined, selectedIcon: Icons.format_quote),
    _NavItem(title: 'Skills', icon: Icons.psychology_outlined, selectedIcon: Icons.psychology),
    _NavItem(title: 'Blogs', icon: Icons.article_outlined, selectedIcon: Icons.article),
    _NavItem(title: 'Messages', icon: Icons.mail_outlined, selectedIcon: Icons.mail),
    _NavItem(title: 'About Me', icon: Icons.info_outlined, selectedIcon: Icons.info),
    _NavItem(title: 'Translations', icon: Icons.translate_outlined, selectedIcon: Icons.translate),
  ];

  Future<void> _logout() async {
    await Supabase.instance.client.auth.signOut();
    if (mounted) {
      context.go('/admin/login');
    }
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Returns the page widget for the currently selected nav index.
  Widget _getSelectedPage(ThemeData theme) {
    switch (_selectedIndex) {
      case 0:
        return const AdminProjectsPage();
      case 1:
        return const AdminTestimonialsPage();
      case 2:
        return const AdminSkillsPage();
      case 3:
        return const AdminBlogsPage();
      case 4:
        return const AdminMessagesPage();
      case 5:
        return const AdminAboutPage();
      case 6:
        return const AdminTranslationsPage();
      default:
        return _buildPlaceholder(theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    if (isMobile) {
      return _buildMobileLayout(context);
    } else {
      return _buildDesktopLayout(context);
    }
  }

  /// Mobile: AppBar + content + BottomNavigationBar
  Widget _buildMobileLayout(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.red),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Container(
        color: theme.scaffoldBackgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: widget.child ?? _getSelectedPage(theme),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        backgroundColor: theme.cardColor,
        indicatorColor: theme.primaryColor.withValues(alpha: 0.15),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: _navItems
            .map(
              (item) => NavigationDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon, color: theme.primaryColor),
                label: item.title,
              ),
            )
            .toList(),
      ),
    );
  }

  /// Tablet/Desktop: NavigationRail + content
  Widget _buildDesktopLayout(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            extended: _isRailExtended,
            minWidth: 72,
            minExtendedWidth: 220,
            backgroundColor: theme.cardColor,
            indicatorColor: theme.primaryColor.withValues(alpha: 0.15),
            selectedIconTheme: IconThemeData(color: theme.primaryColor),
            selectedLabelTextStyle: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelTextStyle: TextStyle(
              color: theme.textTheme.bodyMedium?.color,
            ),
            unselectedIconTheme: IconThemeData(
              color: theme.iconTheme.color,
            ),
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isRailExtended = !_isRailExtended;
                      });
                    },
                    icon: Icon(
                      _isRailExtended ? Icons.menu_open : Icons.menu,
                      color: theme.primaryColor,
                    ),
                    tooltip: _isRailExtended ? 'Collapse' : 'Expand',
                  ).withCursorHover(context),

                ],
              ),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _isRailExtended
                      ? TextButton.icon(
                          onPressed: _logout,
                          icon: const Icon(Icons.logout, color: Colors.red),
                          label: const Text('Logout',
                              style: TextStyle(color: Colors.red)),
                        ).withCursorHover(context)
                      : IconButton(
                          onPressed: _logout,
                          icon: const Icon(Icons.logout, color: Colors.red),
                          tooltip: 'Logout',
                        ).withCursorHover(context),
                ),
              ),
            ),
            destinations: _navItems
                .map(
                  (item) => NavigationRailDestination(
                    icon: Icon(item.icon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: Text(item.title),
                  ),
                )
                .toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.all(24.0),
              child: widget.child ?? _getSelectedPage(theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _navItems[_selectedIndex].selectedIcon,
            size: 64,
            color: theme.primaryColor.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            _navItems[_selectedIndex].title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Content coming soon',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String title;
  final IconData icon;
  final IconData selectedIcon;

  const _NavItem({
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });
}
