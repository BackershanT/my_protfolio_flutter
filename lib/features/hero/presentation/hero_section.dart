import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/hero/data/models/hero_data.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html show AnchorElement;
import 'dart:math';

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewProjects;

  const HeroSection({super.key, this.onViewProjects});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _floatingController;
  int _currentIndex = 0;
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.repeat(reverse: true);

    _floatingController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _floatingController.repeat();

    // Start the role rotation
    Future.delayed(const Duration(seconds: 3), _rotateRole);
  }

  void _rotateRole() {
    if (mounted) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % AppTexts.heroRoles.length;
      });
      Future.delayed(const Duration(seconds: 3), _rotateRole);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  Future<void> _downloadResume() async {
    try {
      if (kIsWeb) {
        // For web, we'll use the asset URL directly
        final url = HeroData.getResumeUrl();
        // Create an anchor element to trigger download
        final anchor = html.AnchorElement(href: url);
        anchor.setAttribute('download', 'BACKERSHAN_T.pdf');
        anchor.click();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Resume download started!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        // For mobile/desktop, download the file to device storage
        final dir = await getApplicationDocumentsDirectory();
        final savePath = '${dir.path}/BACKERSHAN_T.pdf';

        // Create Dio instance
        final dio = Dio();

        // Download the file
        await dio.download(HeroData.getResumeUrl(), savePath);

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Resume downloaded successfully! Check your documents folder.',
              ),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'Open',
                onPressed: () {
                  // On mobile/desktop, we can't directly open the file without additional plugins
                  // So we'll just show the file path
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('File saved to: $savePath'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
              ),
            ),
          );
        }
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not download resume. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                return CustomPaint(
                  painter: BlobPainter(
                    mousePosition: _mousePosition,
                    animationValue: _floatingController.value,
                    isDark: Theme.of(context).brightness == Brightness.dark,
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth < 850
                  ? 20
                  : (screenWidth < 1200 ? 40 : 100),
              vertical: screenWidth < 850 ? 60 : 100,
            ),
            child: Responsive(
              mobile: _buildMobileLayout(),
              desktop: _buildDesktopLayout(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImage(),
        const SizedBox(height: 30),
        _buildTextContent(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth < 1400 ? 40.0 : 80.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: _buildTextContent()),
        SizedBox(width: spacing),
        Flexible(flex: 2, child: Center(child: _buildProfileImage())),
      ],
    );
  }

  Widget _buildProfileImage() {
    final screenWidth = MediaQuery.of(context).size.width;
    final radius = screenWidth < 850
        ? 80.0
        : (screenWidth < 1200 ? 100.0 : 120.0);

    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.primaryLight
          : AppColors.primaryDark,
      child: CircleAvatar(
        radius: radius - 10,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child:
            CircleAvatar(
              radius: radius - 20,
              backgroundImage: AssetImage(AppAssets.profileAvatar),
            ).animate().scale(
              delay: 300.ms,
              duration: 800.ms,
              curve: Curves.elasticOut,
            ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 800.ms);
  }

  Widget _buildTextContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Flutter.dev style: Large, bold headline - RESPONSIVE
        Text(
              AppTexts.heroName,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 32 : (isTablet ? 40 : 56),
                fontWeight: FontWeight.bold,
                height: 1.1,
                letterSpacing: -1,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors
                          .primaryLight // Cyan color for dark mode
                    : null, // Use default color for light mode
              ),
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slide(
              begin: const Offset(0, 0.2),
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        SizedBox(height: isMobile ? 15 : 24),
        // Animated role with Flutter.dev style - RESPONSIVE
        SizedBox(
          height: isMobile ? 50 : 70,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Text(
              AppTexts.heroRoles[_currentIndex],
              key: ValueKey<int>(_currentIndex),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: isMobile ? 20 : (isTablet ? 26 : 38),
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : AppColors.primaryDark,
                height: 1.2,
              ),
            ),
          ),
        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        SizedBox(height: isMobile ? 20 : 30),
        // Description with better readability - RESPONSIVE
        ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 700 : (isTablet ? 500 : double.infinity),
              ),
              child: Text(
                AppTexts.heroDescription,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                  height: 1.7,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withOpacity(0.8),
                ),
              ),
            )
            .animate()
            .fadeIn(delay: 800.ms, duration: 600.ms)
            .slide(
              begin: const Offset(0, 0.2),
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        SizedBox(height: isMobile ? 30 : 40),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildActionButtons() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;

    return Wrap(
      spacing: isMobile ? 12 : 20,
      runSpacing: 16,
      children: [
        // Flutter.dev style: Primary CTA button
        ElevatedButton(
              onPressed: _downloadResume,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : AppColors.primaryDark,
                foregroundColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkBackground
                    : Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 16 : 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                AppTexts.resumeButtonText,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
            .animate()
            .fadeIn(delay: 1000.ms, duration: 600.ms)
            .scale(
              begin: const Offset(0.9, 0.9),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
        // Secondary button
        OutlinedButton(
              onPressed: widget.onViewProjects ?? () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.primaryLight
                    : AppColors.primaryDark,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 16 : 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.primaryLight
                      : AppColors.primaryDark,
                  width: 2,
                ),
              ),
              child: Text(
                AppTexts.viewProjects,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
            .animate()
            .fadeIn(delay: 1200.ms, duration: 600.ms)
            .scale(
              begin: const Offset(0.9, 0.9),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
      ],
    );
  }
}

class BlobPainter extends CustomPainter {
  final Offset mousePosition;
  final double animationValue;
  final bool isDark;

  BlobPainter({
    required this.mousePosition,
    required this.animationValue,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    // Blob 1 - Top Left
    final blob1Center = Offset(
      size.width * 0.2 + (mousePosition.dx - size.width / 2) * 0.05,
      size.height * 0.3 + (mousePosition.dy - size.height / 2) * 0.05,
    );
    paint.color = (isDark ? AppColors.primaryLight : AppColors.primaryDark)
        .withOpacity(isDark ? 0.08 : 0.05);
    canvas.drawCircle(
      blob1Center,
      200 + sin(animationValue * 2 * pi) * 20,
      paint,
    );

    // Blob 2 - Bottom Right
    final blob2Center = Offset(
      size.width * 0.8 + (mousePosition.dx - size.width / 2) * 0.03,
      size.height * 0.7 + (mousePosition.dy - size.height / 2) * 0.03,
    );
    paint.color = (isDark ? Colors.purple : Colors.blue).withOpacity(
      isDark ? 0.05 : 0.03,
    );
    canvas.drawCircle(
      blob2Center,
      250 + cos(animationValue * 2 * pi) * 30,
      paint,
    );

    // Blob 3 - Center Right
    final blob3Center = Offset(
      size.width * 0.9 + (mousePosition.dx - size.width / 2) * 0.02,
      size.height * 0.2 + (mousePosition.dy - size.height / 2) * 0.02,
    );
    paint.color = AppColors.primaryLight.withOpacity(isDark ? 0.06 : 0.04);
    canvas.drawCircle(blob3Center, 150 + sin(animationValue * pi) * 40, paint);
  }

  @override
  bool shouldRepaint(covariant BlobPainter oldDelegate) => true;
}
