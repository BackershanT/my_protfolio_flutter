import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/hero/data/models/hero_data.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';
import 'package:my_protfolio/features/shared/core/utils/threed_effects.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

// Conditional imports for web vs non-web platforms
import 'html_stub.dart' if (dart.library.html) 'dart:html' as html;

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewProjects;

  const HeroSection({super.key, this.onViewProjects});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _starController;
  late AnimationController _gridController;
  late AnimationController _floatController;
  int _currentIndex = 0;
  Offset _mousePosition = Offset.zero;
  Size _widgetSize = Size.zero;

  final List<StarParticle> _stars = [];
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();

    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _generateStars();
    Future.delayed(const Duration(seconds: 3), _rotateRole);
  }

  void _generateStars() {
    _stars.clear();
    final colors = [
      const Color(0xFF64FFDA),
      Colors.white,
      const Color(0xFF7B9FFF),
      const Color(0xFFC0CCFF),
    ];
    for (int i = 0; i < 180; i++) {
      _stars.add(StarParticle(
        x: _rng.nextDouble() * 1920,
        y: _rng.nextDouble() * 1080,
        z: _rng.nextDouble() * 1800 + 200,
        speed: _rng.nextDouble() * 0.4 + 0.05,
        color: colors[_rng.nextInt(colors.length)],
      ));
    }
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
    _starController.dispose();
    _gridController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _downloadResume() async {
    try {
      if (kIsWeb) {
        final assetPath = HeroData.getResumeUrl();
        final ByteData data = await rootBundle.load(assetPath);
        final Uint8List bytes = data.buffer.asUint8List();
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url);
        anchor.setAttribute('download', 'BACKERSHAN_T.pdf');
        anchor.click();
        Future.delayed(const Duration(seconds: 1), () {
          html.Url.revokeObjectUrl(url);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Resume download started!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        final dir = await getApplicationDocumentsDirectory();
        final savePath = '${dir.path}/BACKERSHAN_T.pdf';
        final dio = Dio();
        await dio.download(HeroData.getResumeUrl(), savePath);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Resume downloaded! Check your documents.'),
              backgroundColor: Colors.green,
              action: SnackBarAction(
                label: 'Open',
                onPressed: () {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(builder: (context, constraints) {
      _widgetSize = Size(constraints.maxWidth, constraints.maxHeight);
      return MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePosition = event.localPosition;
          });
        },
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              // ── 3D Starfield background ──
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _starController,
                  builder: (context, _) {
                    // Animate star Z positions (fly-through effect)
                    final t = _starController.value;
                    for (final s in _stars) {
                      s.z -= s.speed * 4;
                      if (s.z <= 10) {
                        s.z = 1800;
                        s.x = _rng.nextDouble() * 1920;
                        s.y = _rng.nextDouble() * 1080;
                      }
                    }
                    return CustomPaint(
                      painter: StarfieldPainter(
                        particles: _stars,
                        cameraZ: 0,
                        isDark: isDark,
                      ),
                    );
                  },
                ),
              ),

              // ── 3D Perspective Grid ──
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _gridController,
                  builder: (context, _) {
                    final shift =
                        (_mousePosition.dx - screenWidth / 2) * 0.03;
                    return CustomPaint(
                      painter: Grid3DPainter(
                        animValue: _gridController.value,
                        isDark: isDark,
                        perspectiveShift: shift,
                      ),
                    );
                  },
                ),
              ),

              // ── Subtle gradient overlay (depth fog) ──
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        (isDark
                                ? AppColors.darkBackground
                                : AppColors.lightBackground)
                            .withOpacity(0.0),
                        (isDark
                                ? AppColors.darkBackground
                                : AppColors.lightBackground)
                            .withOpacity(0.85),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Decorative floating 3D cubes ──
              Positioned(
                top: 80,
                left: screenWidth * 0.08,
                child: FloatingWidget(
                  amplitude: 15,
                  duration: const Duration(seconds: 5),
                  child: RotatingCube(
                    size: 38,
                    color: isDark
                        ? AppColors.primaryLight
                        : AppColors.primaryDark,
                  ),
                ),
              ),
              Positioned(
                bottom: 120,
                right: screenWidth * 0.06,
                child: FloatingWidget(
                  amplitude: 12,
                  duration: const Duration(seconds: 7),
                  child: RotatingCube(
                    size: 28,
                    color: isDark ? Colors.purpleAccent : Colors.blue,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                right: screenWidth * 0.15,
                child: FloatingWidget(
                  amplitude: 8,
                  duration: const Duration(seconds: 6),
                  child: RotatingCube(
                    size: 20,
                    color: isDark ? Colors.cyanAccent : Colors.indigo,
                  ),
                ),
              ),

              // ── Main content ──
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
        ),
      );
    });
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
        : (screenWidth < 1200 ? 100.0 : 130.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppColors.primaryLight : AppColors.primaryDark;

    return FloatingWidget(
      amplitude: 14,
      duration: const Duration(seconds: 4),
      child: TiltCard(
        maxTilt: 20,
        scale: 1.0,
        glareOpacity: 0.2,
        borderRadius: BorderRadius.circular(500),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.4),
                blurRadius: 40,
                spreadRadius: 8,
                offset: const Offset(0, 20),
              ),
              BoxShadow(
                color: primaryColor.withOpacity(0.15),
                blurRadius: 80,
                spreadRadius: 20,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: primaryColor,
            child: CircleAvatar(
              radius: radius - 4,
              backgroundColor: isDark
                  ? AppColors.darkBackground
                  : Colors.white,
              child: CircleAvatar(
                radius: radius - 12,
                backgroundImage: AssetImage(AppAssets.profileAvatar),
              ).animate().scale(
                    delay: 300.ms,
                    duration: 800.ms,
                    curve: Curves.elasticOut,
                  ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 800.ms);
  }

  Widget _buildTextContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isTablet = screenWidth >= 850 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Glowing caption
        Text(
          'I am',
          style: TextStyle(
            fontSize: isMobile ? 12 : 14,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
            color: isDark
                ? AppColors.primaryLight.withOpacity(0.8)
                : AppColors.primaryDark.withOpacity(0.7),
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideX(begin: -0.3, end: 0),
        const SizedBox(height: 12),
        // Large bold headline
        Text(
          AppTexts.heroName,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 32 : (isTablet ? 40 : 60),
                fontWeight: FontWeight.bold,
                height: 1.05,
                letterSpacing: -1.5,
                color: isDark ? AppColors.primaryLight : null,
                shadows: [
                  Shadow(
                    color: (isDark
                            ? AppColors.primaryLight
                            : AppColors.primaryDark)
                        .withOpacity(0.3),
                    blurRadius: 30,
                  ),
                ],
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
        // Animated role switcher
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
                    color:
                        isDark ? AppColors.primaryLight : AppColors.primaryDark,
                    height: 1.2,
                  ),
            ),
          ),
        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        SizedBox(height: isMobile ? 20 : 30),
        // Description
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 700 : (isTablet ? 500 : double.infinity),
          ),
          child: Text(
            AppTexts.heroDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                  height: 1.7,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color
                      ?.withOpacity(0.8),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Wrap(
      spacing: isMobile ? 12 : 20,
      runSpacing: 16,
      children: [
        // Primary CTA
        _Btn3D(
          onPressed: _downloadResume,
          filled: true,
          isDark: isDark,
          label: AppTexts.resumeButtonText,
          isMobile: isMobile,
        ).animate().fadeIn(delay: 1000.ms, duration: 600.ms).scale(
              begin: const Offset(0.9, 0.9),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
        // Secondary CTA
        _Btn3D(
          onPressed: widget.onViewProjects ?? () {},
          filled: false,
          isDark: isDark,
          label: AppTexts.viewProjects,
          isMobile: isMobile,
        ).animate().fadeIn(delay: 1200.ms, duration: 600.ms).scale(
              begin: const Offset(0.9, 0.9),
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  3D-styled button with tilt + glow effect
// ─────────────────────────────────────────────────────────────────
class _Btn3D extends StatefulWidget {
  final VoidCallback onPressed;
  final bool filled;
  final bool isDark;
  final String label;
  final bool isMobile;

  const _Btn3D({
    required this.onPressed,
    required this.filled,
    required this.isDark,
    required this.label,
    required this.isMobile,
  });

  @override
  State<_Btn3D> createState() => _Btn3DState();
}

class _Btn3DState extends State<_Btn3D> {
  bool _hovered = false;
  double _rotY = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isDark
        ? AppColors.primaryLight
        : AppColors.primaryDark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _rotY = 0;
      }),
      onHover: (e) {
        final w = widget.isMobile ? 150.0 : 180.0;
        setState(() {
          _rotY = ((e.localPosition.dx / w) - 0.5) * 0.3; // slight tilt
        });
      },
      child: AnimatedScale(
        scale: _hovered ? 1.06 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_rotY),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 24 : 32,
              vertical: widget.isMobile ? 14 : 18,
            ),
            decoration: BoxDecoration(
              color: widget.filled
                  ? (widget.isDark
                      ? AppColors.primaryLight
                      : AppColors.primaryDark)
                  : Colors.transparent,
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: widget.isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: widget.filled
                      ? (widget.isDark
                          ? AppColors.darkBackground
                          : Colors.white)
                      : primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
