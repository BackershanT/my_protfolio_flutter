import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.paddingLarge,
        vertical: 100.h,
      ),
      child: Responsive(
        mobile: _buildMobileLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: AppTexts.aboutTitle),
        const SizedBox(height: 50),
        _buildProfileImage(context),
        const SizedBox(height: 30),
        _buildAboutContent(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: AppTexts.aboutTitle),
        const SizedBox(height: 50),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: _buildProfileImage(context),
            ),
            SizedBox(width: 50.w),
            Expanded(
              flex: 1,
              child: _buildAboutContent(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      height: 300.h,
      width: 300.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark 
              ? AppColors.primaryLight 
              : AppColors.primaryDark,
          width: 5.w,
        ),
      ),
      child: Icon(
        Icons.person,
        size: 200.sp,
        color: Theme.of(context).brightness == Brightness.dark 
            ? AppColors.primaryLight 
            : AppColors.primaryDark,
      ),
    ).animate().fadeIn(
          delay: 200.ms,
          duration: 800.ms,
        );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTexts.aboutDescription,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.sp,
                height: 1.6,
              ),
        ).animate().fadeIn(
              delay: 400.ms,
              duration: 800.ms,
            ),
        const SizedBox(height: 30),
        _buildHighlights(context),
      ],
    );
  }

  Widget _buildHighlights(BuildContext context) {
    final highlights = [
      '5+ years of experience in Flutter development',
      'Expert in Firebase and backend integration',
      'UI/UX design enthusiast',
      'Open source contributor',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Highlights:',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
        ).animate().fadeIn(
              delay: 600.ms,
              duration: 800.ms,
            ),
        const SizedBox(height: 10),
        ...List.generate(
          highlights.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? AppColors.primaryLight 
                      : AppColors.primaryDark,
                  size: 20.sp,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    highlights[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16.sp,
                    ),
                  ).animate().fadeIn(
                        delay: (800 + (index * 100)).ms,
                        duration: 600.ms,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}