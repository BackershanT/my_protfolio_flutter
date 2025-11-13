import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  // Small screens (phones)
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  // Medium screens (tablets)
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 850 &&
      MediaQuery.of(context).size.width < 1200;

  // Large screens (desktops)
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop;
        } else if (constraints.maxWidth >= 850) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

class Sizes {
  static double get paddingSmall => 8.r;
  static double get paddingMedium => 16.r;
  static double get paddingLarge => 24.r;
  static double get paddingXLarge => 32.r;
  
  static double get marginSmall => 8.r;
  static double get marginMedium => 16.r;
  static double get marginLarge => 24.r;
  static double get marginXLarge => 32.r;
  
  static double get borderRadiusSmall => 4.r;
  static double get borderRadiusMedium => 8.r;
  static double get borderRadiusLarge => 16.r;
}