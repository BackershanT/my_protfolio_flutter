import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/colors.dart';

class TestimonialSkeletonCard extends StatelessWidget {
  const TestimonialSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;
    final skeletonColor = isDark ? Colors.white12 : Colors.black12;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF112240) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 24, height: 24, color: skeletonColor),
              Row(
                children: List.generate(5, (_) {
                  return Container(
                    margin: const EdgeInsets.only(left: 2),
                    width: 14,
                    height: 14,
                    color: skeletonColor,
                  );
                }),
              ),
            ],
          ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: double.infinity, color: skeletonColor),
                const SizedBox(height: 8),
                Container(height: 14, width: double.infinity, color: skeletonColor),
                const SizedBox(height: 8),
                Container(height: 14, width: 180, color: skeletonColor),
              ],
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: skeletonColor,
                ),
              ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 14, width: 100, color: skeletonColor),
                    const SizedBox(height: 6),
                    Container(height: 12, width: 140, color: skeletonColor),
                  ],
                ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
