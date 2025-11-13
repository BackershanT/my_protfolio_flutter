import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/shared/data/models/experience_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final experiences = _getExperiences();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth < 850 ? 20 : (screenWidth < 1200 ? 40 : 100),
        vertical: screenWidth < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: 'Experience'),
          SizedBox(height: screenWidth < 850 ? 50 : 60),
          Responsive(
            mobile: _buildMobileLayout(context, experiences),
            desktop: _buildDesktopLayout(context, experiences),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<Experience> experiences) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        return _buildTimelineItem(context, experiences[index], index);
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context, List<Experience> experiences) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: experiences.length,
        itemBuilder: (context, index) {
          return _buildTimelineItem(context, experiences[index], index);
        },
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, Experience exp, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: exp.isCurrentJob
                      ? (Theme.of(context).brightness == Brightness.dark
                          ? AppColors.primaryLight
                          : AppColors.primaryDark)
                      : Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.primaryLight
                        : AppColors.primaryDark,
                    width: 3,
                  ),
                ),
                child: exp.isCurrentJob
                    ? Icon(
                        Icons.work,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkBackground
                            : Colors.white,
                        size: 24.sp,
                      )
                    : null,
              ).animate().scale(
                    delay: (index * 200).ms,
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  ),
              if (index < _getExperiences().length - 1)
                Container(
                  width: 3.w,
                  height: 100.h,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? AppColors.primaryLight
                          : AppColors.primaryDark)
                      .withOpacity(0.3),
                ).animate().fadeIn(
                      delay: (index * 200 + 300).ms,
                      duration: 600.ms,
                    ),
            ],
          ),
          SizedBox(width: 30.w),
          // Content
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company and duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          exp.company,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.primaryLight
                                    : AppColors.primaryDark,
                              ),
                        ),
                      ),
                      if (exp.isCurrentJob)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: (Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.primaryLight
                                    : AppColors.primaryDark)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            'Current',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.primaryLight
                                  : AppColors.primaryDark,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Role
                  Text(
                    exp.role,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 8.h),
                  // Duration
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.sp,
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.color
                            ?.withOpacity(0.6),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        exp.duration,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Description
                  Text(
                    exp.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15.sp,
                          height: 1.6,
                        ),
                  ),
                  SizedBox(height: 16.h),
                  // Achievements
                  ...exp.achievements.map(
                    (achievement) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 18.sp,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.primaryLight
                                : AppColors.primaryDark,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              achievement,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                    height: 1.5,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(
                  delay: (index * 200 + 200).ms,
                  duration: 600.ms,
                ).slide(
                  begin: const Offset(0.2, 0),
                  duration: 600.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),
        ],
      ),
    );
  }

  List<Experience> _getExperiences() {
    return [
      Experience(
        id: '1',
        company: 'Tech Innovations Inc.',
        role: 'Senior Frontend Developer',
        duration: 'Jan 2023 - Present',
        description:
            'Leading frontend development with Flutter and React, creating cross-platform applications and modern web interfaces.',
        achievements: [
          'Developed 5+ Flutter apps with 100K+ downloads on App Store and Play Store',
          'Built responsive React web applications with excellent performance metrics',
          'Implemented complex UI animations and state management solutions',
          'Mentored junior developers in Flutter and React best practices',
        ],
        isCurrentJob: true,
      ),
      Experience(
        id: '2',
        company: 'Digital Solutions Ltd.',
        role: 'Flutter Developer',
        duration: 'Jun 2021 - Dec 2022',
        description:
            'Specialized in Flutter mobile app development with React web integration.',
        achievements: [
          'Created reusable Flutter component library used across 10+ projects',
          'Built React admin dashboards with Material-UI integration',
          'Implemented Firebase authentication and real-time features',
          'Improved app performance and reduced crash rate by 60%',
        ],
        isCurrentJob: false,
      ),
      Experience(
        id: '3',
        company: 'StartUp Ventures',
        role: 'Junior Frontend Developer',
        duration: 'Jan 2020 - May 2021',
        description:
            'Worked on rapid prototyping and MVP development using Flutter and React.',
        achievements: [
          'Developed 3 Flutter MVPs from concept to production',
          'Built responsive React websites with modern UI/UX',
          'Integrated RESTful APIs and third-party services',
          'Collaborated with designers to implement pixel-perfect UIs',
        ],
        isCurrentJob: false,
      ),
    ];
  }
}
