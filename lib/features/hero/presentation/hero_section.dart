import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/responsive.dart';
import 'package:my_protfolio/core/constants/app_assets.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/features/hero/presentation/widgets/floating_cubes_overlay.dart';
import 'package:my_protfolio/features/hero/presentation/widgets/hero_profile_avatar.dart';
import 'package:my_protfolio/features/hero/presentation/widgets/hero_text_content.dart';
import 'dart:io';
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
  Timer? _roleTimer;

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

    _roleTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % AppTexts.heroRoles.length;
        });
      }
    });
  }

  void _generateStars({int count = 100}) {
    _stars.clear();
    final colors = [
      const Color(0xFF64FFDA),
      Colors.white,
      const Color(0xFF7B9FFF),
      const Color(0xFFC0CCFF),
    ];
    for (int i = 0; i < count; i++) {
      _stars.add(StarParticle(
        x: _rng.nextDouble() * 1920,
        y: _rng.nextDouble() * 1080,
        z: _rng.nextDouble() * 1800 + 200,
        speed: _rng.nextDouble() * 0.4 + 0.05,
        color: colors[_rng.nextInt(colors.length)],
      ));
    }
  }

  @override
  void dispose() {
    _roleTimer?.cancel();
    _starController.dispose();
    _gridController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _downloadResume() async {
    try {
      if (kIsWeb) {
        final assetPath = AppAssets.resume;
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
        final ByteData data = await rootBundle.load(AppAssets.resume);
        final Uint8List bytes = data.buffer.asUint8List();
        final file = File(savePath);
        await file.writeAsBytes(bytes);
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
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: _starController,
                    builder: (context, _) {
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
              ),

              // ── 3D Perspective Grid ──
              Positioned.fill(
                child: RepaintBoundary(
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
              ),

              // ── Depth Fog Gradient Overlay ──
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
                            .withValues(alpha: 0.0),
                        (isDark
                                ? AppColors.darkBackground
                                : AppColors.lightBackground)
                            .withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Decorative floating 3D cubes ──
              FloatingCubesOverlay(
                screenWidth: screenWidth,
                isDark: isDark,
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
        const HeroProfileAvatar(),
        const SizedBox(height: 30),
        HeroTextContent(
          currentIndex: _currentIndex,
          onDownloadResume: _downloadResume,
          onViewProjects: widget.onViewProjects ?? () {},
        ),
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
        Expanded(
          flex: 3,
          child: HeroTextContent(
            currentIndex: _currentIndex,
            onDownloadResume: _downloadResume,
            onViewProjects: widget.onViewProjects ?? () {},
          ),
        ),
        SizedBox(width: spacing),
        const Flexible(
          flex: 2,
          child: Center(
            child: HeroProfileAvatar(),
          ),
        ),
      ],
    );
  }
}
