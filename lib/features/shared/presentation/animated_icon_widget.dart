import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedIconWidget extends StatefulWidget {
  final String assetPath;
  final String label;
  final double size;

  const AnimatedIconWidget({
    super.key,
    required this.assetPath,
    required this.label,
    this.size = 60,
  });

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Transform.scale(
        scale: _isHovered ? 1.2 : 1.0,
        child: Lottie.asset(
          widget.assetPath,
          fit: BoxFit.contain,
        ),
      ).animate(
        target: _isHovered ? 1 : 0,
      ).scale(
        // Disney-style squash and stretch effect
        begin: const Offset(1, 1),
        end: const Offset(1.2, 1.2),
        duration: const Duration(milliseconds: 300),
        curve: Curves.elasticOut,
      ),
    );
  }
}