import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/presentation/custom_cursor.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final String username;
  final List<ProfileStat> stats;
  final String? avatarUrl;
  final IconData brandLogo;
  final Color brandColor;
  final VoidCallback onTap;
  final bool isDark;
  final bool isMobile;

  const ProfileCard({
    super.key,
    required this.title,
    required this.username,
    required this.stats,
    this.avatarUrl,
    required this.brandLogo,
    required this.brandColor,
    required this.onTap,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: isMobile ? double.infinity : 380,
            padding: const EdgeInsets.all(28),
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
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header: Avatar & Brand Logo
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [brandColor, brandColor.withOpacity(0.5)],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: isDark
                            ? const Color(0xFF0A192F)
                            : Colors.grey[200],
                        backgroundImage: avatarUrl != null
                            ? (avatarUrl!.startsWith('assets/')
                                  ? AssetImage(avatarUrl!) as ImageProvider
                                  : NetworkImage(avatarUrl!))
                            : null,
                        child: avatarUrl == null
                            ? Icon(Icons.person, size: 40, color: brandColor)
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF112240)
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.black.withOpacity(0.1),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: brandColor.withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: FaIcon(brandLogo, size: 18, color: brandColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Profile Info
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: brandColor,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: stats
                      .map((stat) => _buildStatItem(stat, isDark))
                      .toList(),
                ),
                const SizedBox(height: 32),

                // Action Button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        brandColor.withOpacity(0.1),
                        brandColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: brandColor.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'viewProfile'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: brandColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: brandColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .withCursorHover(context)
        .animate()
        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildStatItem(ProfileStat stat, bool isDark) {
    return Column(
      children: [
        Text(
          stat.value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              stat.icon,
              size: 12,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
            const SizedBox(width: 6),
            Text(
              stat.label.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: isDark ? Colors.white54 : Colors.black45,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileStat {
  final String label;
  final String value;
  final IconData icon;

  ProfileStat({required this.label, required this.value, required this.icon});
}
