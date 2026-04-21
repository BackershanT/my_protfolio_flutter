import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────
//  3D Tilt Card  (mouse-parallax perspective tilt on hover)
// ─────────────────────────────────────────────────────────────────
class TiltCard extends StatefulWidget {
  final Widget child;
  final double maxTilt; // degrees
  final double scale;
  final double glareOpacity;
  final BorderRadius? borderRadius;

  const TiltCard({
    super.key,
    required this.child,
    this.maxTilt = 12.0,
    this.scale = 1.04,
    this.glareOpacity = 0.15,
    this.borderRadius,
  });

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard>
    with SingleTickerProviderStateMixin {
  double _rotX = 0;
  double _rotY = 0;
  double _glareX = 0.5;
  double _glareY = 0.5;
  bool _hovered = false;

  late AnimationController _springController;
  late Animation<double> _rotXAnim;
  late Animation<double> _rotYAnim;
  double _targetRotX = 0;
  double _targetRotY = 0;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event, BoxConstraints constraints) {
    final dx = event.localPosition.dx;
    final dy = event.localPosition.dy;
    final w = constraints.maxWidth;
    final h = constraints.maxHeight;

    final normX = (dx / w - 0.5) * 2; // -1 .. 1
    final normY = (dy / h - 0.5) * 2; // -1 .. 1

    setState(() {
      _rotY = normX * widget.maxTilt * (pi / 180);
      _rotX = -normY * widget.maxTilt * (pi / 180);
      _glareX = dx / w;
      _glareY = dy / h;
      _hovered = true;
    });
  }

  void _onExit() {
    setState(() {
      _rotX = 0;
      _rotY = 0;
      _hovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return MouseRegion(
        onHover: (e) => _onHover(e, constraints),
        onExit: (_) => _onExit(),
        child: AnimatedScale(
          scale: _hovered ? widget.scale : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateX(_rotX)
              ..rotateY(_rotY),
            child: ClipRRect(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  widget.child,
                  // Glare overlay – strictly clipped inside card bounds
                  if (_hovered)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment(
                                _glareX * 2 - 1,
                                _glareY * 2 - 1,
                              ),
                              radius: 0.8,
                              colors: [
                                Colors.white.withOpacity(widget.glareOpacity),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────
//  3D Particle Star-field painter
// ─────────────────────────────────────────────────────────────────
class StarParticle {
  double x, y, z;
  double speed;
  Color color;

  StarParticle({
    required this.x,
    required this.y,
    required this.z,
    required this.speed,
    required this.color,
  });
}

class StarfieldPainter extends CustomPainter {
  final List<StarParticle> particles;
  final double cameraZ;
  final bool isDark;

  StarfieldPainter({
    required this.particles,
    required this.cameraZ,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final fov = 500.0;

    for (final p in particles) {
      final dz = p.z - cameraZ;
      if (dz <= 0) continue;

      final projX = cx + (p.x - cx) * fov / dz;
      final projY = cy + (p.y - cy) * fov / dz;
      final projSize = (1 - dz / 2000) * 3.5;

      if (projX < 0 ||
          projX > size.width ||
          projY < 0 ||
          projY > size.height) continue;
      if (projSize <= 0) continue;

      final alpha = (1.0 - dz / 2000).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = p.color.withOpacity(alpha * (isDark ? 0.9 : 0.5))
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, projSize * 0.5);

      canvas.drawCircle(Offset(projX, projY), projSize.clamp(0.5, 4.0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarfieldPainter old) => true;
}

// ─────────────────────────────────────────────────────────────────
//  Floating 3D element (continuous levitation + shadow)
// ─────────────────────────────────────────────────────────────────
class FloatingWidget extends StatefulWidget {
  final Widget child;
  final double amplitude;
  final Duration duration;

  const FloatingWidget({
    super.key,
    required this.child,
    this.amplitude = 10.0,
    this.duration = const Duration(seconds: 4),
  });

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _anim = Tween<double>(
      begin: -widget.amplitude,
      end: widget.amplitude,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _anim.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  3D Rotating Cube decoration widget
// ─────────────────────────────────────────────────────────────────
class RotatingCube extends StatefulWidget {
  final double size;
  final Color color;

  const RotatingCube({super.key, this.size = 40, required this.color});

  @override
  State<RotatingCube> createState() => _RotatingCubeState();
}

class _RotatingCubeState extends State<RotatingCube>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final angle = _ctrl.value * 2 * pi;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(angle)
            ..rotateX(angle * 0.5),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.15),
              border: Border.all(color: widget.color.withOpacity(0.6), width: 1.5),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  Animated 3D Grid background painter
// ─────────────────────────────────────────────────────────────────
class Grid3DPainter extends CustomPainter {
  final double animValue;
  final bool isDark;
  final double perspectiveShift;

  Grid3DPainter({
    required this.animValue,
    required this.isDark,
    this.perspectiveShift = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = (isDark ? const Color(0xFF64FFDA) : const Color(0xFF0A192F))
          .withOpacity(isDark ? 0.08 : 0.04);

    // Perspective vanishing point
    final vp = Offset(size.width / 2 + perspectiveShift, size.height * 0.4);
    const rows = 20;
    const cols = 20;
    final cellW = size.width / cols;
    final cellH = size.height / 2 / rows;

    // Animate the grid scroll
    final yOffset = (animValue * cellH * 2) % cellH;

    // Draw horizontal lines with perspective
    for (int row = 0; row <= rows + 1; row++) {
      final y = size.height / 2 + row * cellH - yOffset;
      if (y < size.height / 2 - 10 || y > size.height + 5) continue;
      final t = (y - size.height / 2) / (size.height / 2);
      final leftX = lerpDouble(vp.dx, 0, t)!;
      final rightX = lerpDouble(vp.dx, size.width, t)!;
      canvas.drawLine(Offset(leftX, y), Offset(rightX, y), paint);
    }

    // Draw vertical lines with perspective
    for (int col = 0; col <= cols; col++) {
      final x = col * cellW;
      final t0 = 0.0;
      final t1 = 1.0;
      final x0 = lerpDouble(vp.dx, x, t0)!;
      final y0 = lerpDouble(vp.dy, size.height, t0)!;
      final x1 = lerpDouble(vp.dx, x, t1)!;
      final y1 = lerpDouble(vp.dy, size.height, t1)!;
      canvas.drawLine(Offset(x0, size.height / 2), Offset(x1, y1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant Grid3DPainter old) =>
      old.animValue != animValue || old.perspectiveShift != perspectiveShift;
}
