import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/shared/data/models/github_stats_model.dart';
import 'package:my_protfolio/features/shared/data/services/github_service.dart';
import 'package:my_protfolio/features/shared/data/models/linkedin_stats_model.dart';
import 'package:my_protfolio/features/shared/data/services/linkedin_service.dart';
import 'package:my_protfolio/features/shared/presentation/custom_cursor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

class ProfilesSection extends StatefulWidget {
  const ProfilesSection({super.key});

  @override
  State<ProfilesSection> createState() => _ProfilesSectionState();
}

class _ProfilesSectionState extends State<ProfilesSection> {
  late Future<GithubStats> _githubStatsFuture;
  late Future<LinkedInStats> _linkedinStatsFuture;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _githubStatsFuture = GithubService('BackershanT').fetchStats();
    _linkedinStatsFuture = LinkedInService().fetchStats();
    _pageController = PageController(viewportFraction: 0.9);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 2;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : screenWidth * 0.1,
        vertical: 80,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 0),
            child: SectionTitle(title: AppTexts.navProfiles),
          ),
          const SizedBox(height: 60),

          FutureBuilder<List<dynamic>>(
            future: Future.wait([_githubStatsFuture, _linkedinStatsFuture]),
            builder: (context, snapshot) {
              final githubStats = snapshot.hasData
                  ? snapshot.data![0] as GithubStats
                  : null;
              final linkedinStats = snapshot.hasData
                  ? snapshot.data![1] as LinkedInStats
                  : null;

              final cards = [
                // GitHub Card
                _buildClassicProfileCard(
                  title: 'GitHub',
                  username: githubStats?.username ?? 'BackershanT',
                  headline:
                      'Flutter & React Developer UI/UX | Firebase | Building scalable apps & sleek interfaces',
                  stats: [
                    _Stat(
                      label: 'Repos',
                      value: githubStats?.publicRepos.toString() ?? '...',
                      icon: FontAwesomeIcons.bookBookmark,
                    ),
                    _Stat(
                      label: 'Stars',
                      value: githubStats?.totalStars.toString() ?? '...',
                      icon: FontAwesomeIcons.solidStar,
                    ),
                  ],
                  avatarUrl: githubStats?.avatarUrl,
                  brandLogo: FontAwesomeIcons.github,
                  brandColor: isDark ? Colors.white : Colors.black87,
                  profileUrl: 'https://github.com/BackershanT',
                  isDark: isDark,
                  isMobile: isMobile,
                ),

                // LinkedIn Card
                _buildClassicProfileCard(
                  title: 'LinkedIn',
                  username: linkedinStats?.username ?? 'Backershan T',
                  headline:
                      linkedinStats?.headline ?? 'Flutter & Software Engineer',
                  stats: [
                    _Stat(
                      label: 'Conns',
                      value: linkedinStats?.connections ?? '...',
                      icon: FontAwesomeIcons.users,
                    ),
                    _Stat(
                      label: 'Endorsed',
                      value: linkedinStats?.endorsements ?? '...',
                      icon: FontAwesomeIcons.award,
                    ),
                  ],
                  avatarUrl: linkedinStats?.profileImageUrl,
                  brandLogo: FontAwesomeIcons.linkedin,
                  brandColor: const Color(0xFF0077B5),
                  profileUrl:
                      'https://www.linkedin.com/in/backershan-t-9b5b3b21b/',
                  isDark: isDark,
                  isMobile: isMobile,
                ),
              ];

              if (isMobile) {
                return SizedBox(
                  height: 480, // Height to fit the card
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: cards.length,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: cards[index],
                      );
                    },
                  ),
                );
              }

              return Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: cards,
              );
            },
          ),

          if (isMobile) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.primaryLight
                        : (isDark ? Colors.white24 : Colors.black12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildClassicProfileCard({
    required String title,
    required String username,
    required String headline,
    required List<_Stat> stats,
    String? avatarUrl,
    required IconData brandLogo,
    required Color brandColor,
    required String profileUrl,
    required bool isDark,
    required bool isMobile,
  }) {
    return InkWell(
          onTap: () => _launchUrl(profileUrl),
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: isMobile ? double.infinity : 400,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF112240).withOpacity(0.4)
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.05),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header: Avatar & Brand Logo
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: brandColor.withOpacity(0.1),
                      backgroundImage: avatarUrl != null
                          ? NetworkImage(avatarUrl)
                          : null,
                      child: avatarUrl == null
                          ? Icon(Icons.person, size: 40, color: brandColor)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF0A192F)
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: brandColor, width: 2),
                        ),
                        child: FaIcon(brandLogo, size: 16, color: brandColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Info
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  headline,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 24),
                Container(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
                const SizedBox(height: 24),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: stats
                      .map((stat) => _buildStatItem(stat, isDark))
                      .toList(),
                ),

                const SizedBox(height: 24),

                // Action Button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: brandColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: brandColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'viewProfile'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: brandColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.open_in_new, size: 16, color: brandColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .withCursorHover(context)
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic);
  }

  Widget _buildStatItem(_Stat stat, bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            FaIcon(stat.icon, size: 14, color: AppColors.primaryLight),
            const SizedBox(width: 8),
            Text(
              stat.value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          stat.label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class _Stat {
  final String label;
  final String value;
  final IconData icon;

  _Stat({required this.label, required this.value, required this.icon});
}
