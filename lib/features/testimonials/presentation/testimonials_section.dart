import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';
import 'package:my_protfolio/core/presentation/widgets/section_title.dart';
import 'package:my_protfolio/core/presentation/widgets/custom_cursor.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/admin/data/providers/testimonial_provider.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  PageController? _pageController;
  double? _currentViewportFraction;
  int _activeItemIndex = 0;
  Timer? _timer;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TestimonialProvider>().loadTestimonials();
    });
  }

  void _setupAutoScroll(int itemCount) {
    if (_timer != null) return;
    if (itemCount <= 1) return;

    _timer = Timer.periodic(const Duration(milliseconds: 3800), (_) {
      if (_pageController != null && _pageController!.hasClients && !_isHovered) {
        _pageController!.nextPage(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  PageController _getController(double viewportFraction, int itemCount) {
    if (_pageController == null || _currentViewportFraction != viewportFraction) {
      final initialPage = _pageController != null && _pageController!.hasClients
          ? (_pageController!.page?.round() ?? (itemCount * 100))
          : (itemCount > 0 ? itemCount * 100 : 0);

      _pageController?.dispose();
      _currentViewportFraction = viewportFraction;
      _pageController = PageController(
        initialPage: initialPage,
        viewportFraction: viewportFraction,
      );
    }
    return _pageController!;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  double _calculateViewportFraction(double screenWidth) {
    if (screenWidth < 650) {
      return 0.92; // 1 card visible on mobile
    } else if (screenWidth < 1100) {
      return 0.48; // 2 cards visible on tablet
    } else {
      return 0.32; // 3 cards visible on desktop
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 650;
    final isTablet = screenWidth >= 650 && screenWidth < 1100;
    final viewportFraction = _calculateViewportFraction(screenWidth);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : (isTablet ? 30 : 60),
        vertical: isMobile ? 60 : 90,
      ),
      child: Column(
        children: [
          SectionTitle(title: AppTexts.testimonialsTitle),
          SizedBox(height: isMobile ? 35 : 50),
          Consumer<TestimonialProvider>(
            builder: (context, provider, child) {
              final isLoading = provider.isLoading;
              final items = provider.testimonials;

              if (isLoading && items.isEmpty) {
                return _buildSkeletonLayout(isMobile, isTablet);
              }

              if (items.isEmpty) {
                return const SizedBox.shrink();
              }

              _setupAutoScroll(items.length);
              final controller = _getController(viewportFraction, items.length);

              return MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: Column(
                  children: [
                    // Auto-scrolling Carousel Viewport
                    SizedBox(
                      height: isMobile ? 390 : 370,
                      child: PageView.builder(
                        controller: controller,
                        onPageChanged: (index) {
                          setState(() {
                            _activeItemIndex = index % items.length;
                          });
                        },
                        itemBuilder: (context, index) {
                          final item = items[index % items.length];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _buildTestimonialCard(
                              context,
                              item,
                              isMobile: isMobile,
                              isDark: isDark,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Controls Row: Left Arrow, Page Indicators, Right Arrow
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Previous Arrow Button
                        IconButton(
                          onPressed: () {
                            controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutCubic,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 18,
                            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                          ),
                          tooltip: 'Previous',
                        ).withCursorHover(context),

                        const SizedBox(width: 12),

                        // Page Indicator Dots
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(items.length, (index) {
                            final isSelected = _activeItemIndex == index;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: isSelected ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: isSelected
                                    ? (isDark ? AppColors.primaryLight : AppColors.primaryDark)
                                    : (isDark
                                        ? Colors.white.withValues(alpha: 0.2)
                                        : Colors.black.withValues(alpha: 0.2)),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(width: 12),

                        // Next Arrow Button
                        IconButton(
                          onPressed: () {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutCubic,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                          ),
                          tooltip: 'Next',
                        ).withCursorHover(context),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(
    BuildContext context,
    dynamic testimonial,
    {required bool isMobile, required bool isDark}
  ) {
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
          // Top Row: Quote mark + Rating Stars from Supabase
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

  Widget _buildSkeletonLayout(bool isMobile, bool isTablet) {
    final count = isMobile ? 1 : (isTablet ? 2 : 3);
    return SizedBox(
      height: isMobile ? 390 : 370,
      child: Row(
        children: List.generate(count, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const _SkeletonCard(),
            ),
          );
        }),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

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
