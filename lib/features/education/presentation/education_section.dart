import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth < 850 ? 20 : (screenWidth < 1200 ? 40 : 100),
        vertical: screenWidth < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: 'Education'),
          SizedBox(height: screenWidth < 850 ? 50 : 60),
          Responsive(
            mobile: _buildMobileLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final education = _getEducation();
    return Column(
      children: education
          .asMap()
          .entries
          .map((entry) => Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: _buildEducationCard(context, entry.value, entry.key),
              ))
          .toList(),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final education = _getEducation();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: education
            .asMap()
            .entries
            .map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _buildEducationCard(context, entry.value, entry.key),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildEducationCard(
    BuildContext context,
    Map<String, String> edu,
    int index,
  ) {
    return Container(
      padding: EdgeInsets.all(30.r),
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
      child: Row(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.primaryLight.withOpacity(0.1)
                  : AppColors.primaryDark.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.school,
              size: 40.sp,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.primaryLight
                  : AppColors.primaryDark,
            ),
          ).animate().scale(
                delay: (index * 200).ms,
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),
          SizedBox(width: 24.w),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu['degree']!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                ),
                SizedBox(height: 8.h),
                Text(
                  edu['institution']!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.primaryLight
                            : AppColors.primaryDark,
                      ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14.sp,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.6),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      edu['year']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withOpacity(0.6),
                          ),
                    ),
                    SizedBox(width: 20.w),
                    if (edu.containsKey('grade'))
                      Row(
                        children: [
                          Icon(
                            Icons.grade,
                            size: 14.sp,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withOpacity(0.6),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            edu['grade']!,
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
          delay: (index * 200).ms,
          duration: 600.ms,
        ).slide(
          begin: const Offset(0, 0.2),
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }

  List<Map<String, String>> _getEducation() {
    return [
      {
        'degree': 'Bachelor of Technology in Computer Science',
        'institution': 'University of Technology',
        'year': '2016 - 2020',
        'grade': 'CGPA: 8.5/10',
      },
      {
        'degree': 'Senior Secondary Education',
        'institution': 'High School of Excellence',
        'year': '2014 - 2016',
        'grade': 'Percentage: 92%',
      },
    ];
  }
}
