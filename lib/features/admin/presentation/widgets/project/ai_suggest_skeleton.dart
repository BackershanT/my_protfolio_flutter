import 'package:flutter/material.dart';

/// Shimmer skeleton shown while AI suggestions are being generated.
class AiSuggestSkeleton extends StatelessWidget {
  final Animation<double> shimmer;
  final bool isDark;

  const AiSuggestSkeleton({
    super.key,
    required this.shimmer,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shimmer,
      builder: (_, __) {
        final t = (shimmer.value * 2).clamp(0.0, 2.0);
        final lerp = t > 1 ? 2 - t : t;
        final shimmerColor = isDark
            ? (Color.lerp(const Color(0xFF1A1A2E), const Color(0xFF2A2A45), lerp) ?? const Color(0xFF1A1A2E))
            : (Color.lerp(Colors.grey.shade200, Colors.grey.shade100, lerp) ?? Colors.grey.shade200);

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFF6C63FF), size: 20),
                  const SizedBox(width: 8),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFFB06AB3), Color(0xFF6C63FF)],
                    ).createShader(bounds),
                    child: const Text(
                      'Analysing your project...',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              for (int i = 0; i < 4; i++) ...[
                _bar(shimmerColor, i == 3 ? 0.6 : 1.0),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 20),
              for (int i = 0; i < 3; i++) ...[
                _bar(shimmerColor, [0.8, 0.9, 0.7][i]),
                const SizedBox(height: 10),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _bar(Color color, double widthFactor) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: 14,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
