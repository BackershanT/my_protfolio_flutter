import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/shared/data/models/github_stats_model.dart';
import 'package:my_protfolio/features/shared/data/services/github_service.dart';
import 'package:my_protfolio/features/shared/data/models/linkedin_stats_model.dart';
import 'package:my_protfolio/features/shared/data/services/linkedin_service.dart';
import 'package:my_protfolio/features/shared/data/models/instagram_stats_model.dart';
import 'package:my_protfolio/features/shared/data/services/instagram_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_protfolio/features/shared/presentation/profile_card.dart';
import 'package:my_protfolio/features/shared/core/config/stats_config.dart';

import 'dart:async';

class ProfilesSection extends StatefulWidget {
  const ProfilesSection({super.key});

  @override
  State<ProfilesSection> createState() => _ProfilesSectionState();
}

class _ProfilesSectionState extends State<ProfilesSection> {
  late Future<GithubStats> _githubStatsFuture;
  late Future<LinkedInStats> _linkedinStatsFuture;
  late Future<InstagramStats> _instagramStatsFuture;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _githubStatsFuture = GithubService().fetchStats();
    _linkedinStatsFuture = LinkedInService().fetchStats();
    _instagramStatsFuture = InstagramService().fetchStats();
    _pageController = PageController(viewportFraction: 0.9);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 3;
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
            future: Future.wait([
              _githubStatsFuture,
              _linkedinStatsFuture,
              _instagramStatsFuture,
            ]),
            builder: (context, snapshot) {
              final githubStats = snapshot.hasData
                  ? snapshot.data![0] as GithubStats
                  : null;
              final linkedinStats = snapshot.hasData
                  ? snapshot.data![1] as LinkedInStats
                  : null;
              final instagramStats = snapshot.hasData
                  ? snapshot.data![2] as InstagramStats
                  : null;

              final cards = [
                // GitHub Card
                ProfileCard(
                  title: 'GitHub',
                  username: githubStats?.username ?? 'BackershanT',
                  stats: [
                    ProfileStat(
                      label: 'Repos',
                      value: githubStats?.publicRepos.toString() ?? '...',
                      icon: FontAwesomeIcons.bookBookmark,
                    ),
                    ProfileStat(
                      label: 'Stars',
                      value: githubStats?.totalStars.toString() ?? '...',
                      icon: FontAwesomeIcons.solidStar,
                    ),
                  ],
                  avatarUrl: githubStats?.avatarUrl,
                  brandLogo: FontAwesomeIcons.github,
                  brandColor: isDark ? Colors.white : Colors.black87,
                  onTap: () => _launchUrl(
                    'https://github.com/${StatsConfig.githubUsername}',
                  ),
                  isDark: isDark,
                  isMobile: isMobile,
                ),

                // LinkedIn Card
                ProfileCard(
                  title: 'LinkedIn',
                  username: linkedinStats?.username ?? 'Backershan T',
                  stats: [
                    ProfileStat(
                      label: 'Connections',
                      value: linkedinStats?.connections ?? '...',
                      icon: FontAwesomeIcons.users,
                    ),
                    ProfileStat(
                      label: 'Followers',
                      value: linkedinStats?.followers ?? '...',
                      icon: FontAwesomeIcons.peopleGroup,
                    ),
                  ],
                  avatarUrl: linkedinStats?.profileImageUrl,
                  brandLogo: FontAwesomeIcons.linkedin,
                  brandColor: const Color(0xFF0077B5),
                  onTap: () => _launchUrl(
                    'https://www.linkedin.com/in/${StatsConfig.linkedinUsername}/',
                  ),
                  isDark: isDark,
                  isMobile: isMobile,
                ),

                // Instagram Card
                ProfileCard(
                  title: 'Instagram',
                  username: instagramStats?.username ?? 'backershan.t.2025',
                  stats: [
                    ProfileStat(
                      label: 'Posts',
                      value: instagramStats?.posts ?? '...',
                      icon: FontAwesomeIcons.image,
                    ),
                    ProfileStat(
                      label: 'Followers',
                      value: instagramStats?.followers ?? '...',
                      icon: FontAwesomeIcons.heart,
                    ),
                  ],
                  avatarUrl: instagramStats?.profileImageUrl,
                  brandLogo: FontAwesomeIcons.instagram,
                  brandColor: const Color(0xFFE1306C),
                  onTap: () => _launchUrl(
                    'https://www.instagram.com/${StatsConfig.instagramUsername}/',
                  ),
                  isDark: isDark,
                  isMobile: isMobile,
                ),
              ];

              if (isMobile) {
                return SizedBox(
                  height: 440, // Reduced height as headline is removed
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
                3,
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
}
