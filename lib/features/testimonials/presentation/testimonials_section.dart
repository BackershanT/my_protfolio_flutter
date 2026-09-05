import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/responsive.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';
import 'package:my_protfolio/core/presentation/widgets/section_title.dart';

import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/providers/testimonial_provider.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TestimonialProvider>().loadTestimonials();
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // We calculate the length dynamically where it's used now.
        final page = _pageController.page?.toInt() ?? 0;
        _pageController.animateToPage(
          page + 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width < 850
            ? 20
            : (MediaQuery.of(context).size.width < 1200 ? 40 : 100),
        vertical: MediaQuery.of(context).size.width < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: AppTexts.testimonialsTitle),
          SizedBox(height: MediaQuery.of(context).size.width < 850 ? 40 : 50),
          Consumer<TestimonialProvider>(
            builder: (context, provider, child) {
              final isLoading = provider.isLoading;
              final items = provider.testimonials;
              
              if (isLoading && items.isEmpty) {
                 // Use Skeleton
                 return Responsive(
                   mobile: _buildMobileSkeleton(context),
                   desktop: _buildDesktopSkeleton(context),
                 );
              }

              return Responsive(
                mobile: _buildMobileLayout(context, items),
                desktop: _buildDesktopLayout(context, items),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, List<dynamic> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        SizedBox(
          height: 380,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index % items.length;
              });
            },
            itemBuilder: (context, index) {
              return _buildTestimonialCard(context, items[index % items.length], true);
            },
          ),
        ),
        SizedBox(height: 20),
        // Page indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(items.length > 5 ? 5 : items.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, List<dynamic> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        // Display testimonials in a row like the about section
        SizedBox(
          height: 350,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.take(3)
                .map(
                  (testimonial) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _buildTestimonialCard(context, testimonial, false),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileSkeleton(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Center(
        child: const _SkeletonCard(isMobile: true),
      ),
    );
  }

  Widget _buildDesktopSkeleton(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(3, (index) {
          return const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: _SkeletonCard(isMobile: false),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTestimonialCard(
    BuildContext context,
    dynamic testimonial, // Use dynamic to handle both admin model and fallback model
    bool isMobile,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;

    final cardWidth = isMobile ? 280.0 : 350.0;
    final padding = isMobile ? 20.0 : (screenWidth < 1200 ? 24.0 : 30.0);
    final contentSize = isMobile ? 14.0 : 16.0;
    final nameSize = isMobile ? 18.0 : 20.0;
    final roleSize = isMobile ? 13.0 : 15.0;

    final cardInner = Container(
      width: isMobile ? cardWidth : null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF112240) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.18),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: isDark ? 0.12 : 0.06),
            blurRadius: 30,
            spreadRadius: 2,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big decorative quote mark
          Text(
            '❝',
            style: TextStyle(
              fontSize: isMobile ? 36 : 48,
              height: 1,
              color: primaryColor.withValues(alpha: 0.35),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Testimonial content
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                testimonial.content,
                style: TextStyle(
                  fontSize: contentSize,
                  height: 1.7,
                  fontStyle: FontStyle.italic,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ).animate().fadeIn(duration: 600.ms),
            ),
          ),
          SizedBox(height: isMobile ? 20 : 28),
          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Client info
          Row(
            children: [
              Container(
                width: isMobile ? 44 : 52,
                height: isMobile ? 44 : 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.2),
                      blurRadius: 12,
                      spreadRadius: 1,
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
                        Icons.person,
                        size: isMobile ? 22 : 26,
                        color: isDark ? Colors.white54 : Colors.black45,
                      )
                    : null,
              ),
              const SizedBox(width: 14),
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
                    ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                    const SizedBox(height: 3),
                    Text(
                      '${testimonial.role}${testimonial.company != null && testimonial.company.toString().isNotEmpty ? ' · ${testimonial.company}' : ''}',
                      style: TextStyle(
                        fontSize: roleSize,
                        color: primaryColor.withValues(alpha: 0.75),
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(delay: 350.ms, duration: 600.ms),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final card = TiltCard(
      maxTilt: isMobile ? 0 : 13,
      scale: isMobile ? 1.0 : 1.03,
      glareOpacity: 0.10,
      child: cardInner,
    );

    if (isMobile) {
      return Container(
        width: cardWidth,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: card,
      );
    }
    return card;
  }
}

class _SkeletonCard extends StatelessWidget {
  final bool isMobile;
  const _SkeletonCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;
    
    final cardWidth = isMobile ? 280.0 : 350.0;
    final padding = isMobile ? 20.0 : 30.0;
    final skeletonColor = isDark ? Colors.white12 : Colors.black12;

    final cardInner = Container(
      width: isMobile ? cardWidth : null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF112240) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            color: skeletonColor,
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
                Container(height: 14, width: cardWidth * 0.6, color: skeletonColor),
              ],
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
          ),
          SizedBox(height: isMobile ? 20 : 28),
          Row(
            children: [
              Container(
                width: isMobile ? 44 : 52,
                height: isMobile ? 44 : 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: skeletonColor,
                ),
              ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16, width: 100, color: skeletonColor),
                    const SizedBox(height: 6),
                    Container(height: 12, width: 150, color: skeletonColor),
                  ],
                ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 1200.ms, color: Colors.white24),
              ),
            ],
          ),
        ],
      ),
    );

    if (isMobile) {
      return Container(
        width: cardWidth,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: cardInner,
      );
    }
    return cardInner;
  }
}
