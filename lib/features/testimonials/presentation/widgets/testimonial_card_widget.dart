import 'package:flutter/material.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';

class TestimonialCardWidget extends StatelessWidget {
  final dynamic testimonial;
  final bool isMobile;
  final bool isDark;

  const TestimonialCardWidget({
    super.key,
    required this.testimonial,
    required this.isMobile,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;
    final padding = isMobile ? 18.0 : 24.0;
    final nameSize = isMobile ? 16.0 : 18.0;
    final roleSize = isMobile ? 12.0 : 13.5;
    final contentSize = isMobile ? 13.5 : 14.5;

    final int ratingCount = (testimonial.rating is int)
        ? (testimonial.rating as int).clamp(1, 5)
        : 5;

    final cardChild = Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF112240) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: isDark ? 0.10 : 0.05),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Quote mark + Rating Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '❝',
                style: TextStyle(
                  fontSize: isMobile ? 32 : 40,
                  height: 1,
                  color: primaryColor.withValues(alpha: 0.4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  final isFilled = index < ratingCount;
                  return Icon(
                    isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: isMobile ? 16 : 18,
                    color: isFilled
                        ? const Color(0xFFFFC107)
                        : (isDark ? Colors.white24 : Colors.black26),
                  );
                }),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Testimonial Text Body
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                testimonial.content,
                style: TextStyle(
                  fontSize: contentSize,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                  color: isDark ? Colors.white.withValues(alpha: 0.85) : Colors.black87,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Soft Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withValues(alpha: 0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Client Info (Avatar, Name, Role & Company)
          Row(
            children: [
              Container(
                width: isMobile ? 42 : 48,
                height: isMobile ? 42 : 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.15),
                      blurRadius: 8,
                    ),
                  ],
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.05),
                  image: (testimonial.avatarUrl ?? '').isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(testimonial.avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: (testimonial.avatarUrl ?? '').isEmpty
                    ? Icon(
                        Icons.person_rounded,
                        size: isMobile ? 22 : 26,
                        color: isDark ? Colors.white54 : Colors.black45,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.name,
                      style: TextStyle(
                        fontSize: nameSize,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${testimonial.role}${testimonial.company != null && testimonial.company.toString().isNotEmpty ? ' · ${testimonial.company}' : ''}',
                      style: TextStyle(
                        fontSize: roleSize,
                        color: primaryColor.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return TiltCard(
      maxTilt: isMobile ? 0 : 8,
      scale: isMobile ? 1.0 : 1.02,
      glareOpacity: 0.08,
      child: cardChild,
    );
  }
}
