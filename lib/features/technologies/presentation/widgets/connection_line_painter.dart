import 'package:flutter/material.dart';
import 'dart:math' as math;

class ConnectionLinePainter extends CustomPainter {
  final double angle;
  final double radius;
  final Color color;

  ConnectionLinePainter({
    required this.angle,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final techOffset = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(techOffset.dx, techOffset.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ConnectionLinePainter oldDelegate) {
    return oldDelegate.angle != angle ||
        oldDelegate.radius != radius ||
        oldDelegate.color != color;
  }
}
