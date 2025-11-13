import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.paddingLarge,
        vertical: 30.h,
      ),
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkBackground.withOpacity(0.8)
          : Colors.grey.shade200,
      child: Column(
        children: [
          Text(
            AppTexts.footerText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.secondaryText
                      : AppColors.lightText,
                ),
          ),
        ],
      ),
    );
  }
}