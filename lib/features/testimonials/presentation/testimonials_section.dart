import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/core/constants/app_texts.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/presentation/widgets/section_title.dart';
import 'package:my_protfolio/core/presentation/widgets/custom_cursor.dart';
import 'package:my_protfolio/features/admin/data/providers/testimonial_provider.dart';
import 'package:my_protfolio/features/testimonials/presentation/widgets/testimonial_card_widget.dart';
import 'package:my_protfolio/features/testimonials/presentation/widgets/testimonial_skeleton_card.dart';

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
      return 0.92;
    } else if (screenWidth < 1100) {
      return 0.48;
    } else {
      return 0.32;
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
                            child: TestimonialCardWidget(
                              testimonial: item,
                              isMobile: isMobile,
                              isDark: isDark,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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

  Widget _buildSkeletonLayout(bool isMobile, bool isTablet) {
    final count = isMobile ? 1 : (isTablet ? 2 : 3);
    return SizedBox(
      height: isMobile ? 390 : 370,
      child: Row(
        children: List.generate(count, (index) {
          return const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TestimonialSkeletonCard(),
            ),
          );
        }),
      ),
    );
  }
}
