import 'package:flutter/material.dart';

/// Interactive star rating widget.
/// 
/// In [interactive] mode (default), stars are tappable to set rating.
/// In display-only mode, stars are non-interactive.
class StarRatingWidget extends StatelessWidget {
  final int rating;
  final ValueChanged<int>? onRatingChanged;
  final bool interactive;
  final double starSize;
  final Color? activeColor;
  final Color? inactiveColor;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.onRatingChanged,
    this.interactive = true,
    this.starSize = 28,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = activeColor ?? Colors.amber;
    final inactive = inactiveColor ?? theme.dividerColor.withOpacity(0.4);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= rating;

        return GestureDetector(
          onTap: interactive ? () => onRatingChanged?.call(starIndex) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Icon(
              isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
              size: starSize,
              color: isFilled ? active : inactive,
            ),
          ),
        );
      }),
    );
  }
}
