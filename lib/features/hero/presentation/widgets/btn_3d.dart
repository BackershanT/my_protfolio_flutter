import 'package:flutter/material.dart';
import 'package:my_protfolio/core/constants/colors.dart';

class Btn3D extends StatefulWidget {
  final VoidCallback onPressed;
  final bool filled;
  final bool isDark;
  final String label;
  final bool isMobile;

  const Btn3D({
    super.key,
    required this.onPressed,
    required this.filled,
    required this.isDark,
    required this.label,
    required this.isMobile,
  });

  @override
  State<Btn3D> createState() => _Btn3DState();
}

class _Btn3DState extends State<Btn3D> {
  bool _hovered = false;
  double _rotY = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isDark
        ? AppColors.primaryLight
        : AppColors.primaryDark;

    return MouseRegion(
      onEnter: (_) {
        if (mounted) setState(() => _hovered = true);
      },
      onExit: (_) {
        if (mounted) {
          setState(() {
            _hovered = false;
            _rotY = 0;
          });
        }
      },
      onHover: (e) {
        final w = widget.isMobile ? 150.0 : 180.0;
        if (mounted) {
          setState(() {
            _rotY = ((e.localPosition.dx / w) - 0.5) * 0.3; // slight tilt
          });
        }
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
                        color: primaryColor.withValues(alpha: 0.5),
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
