import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/core/utils/threed_effects.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/shared/data/models/testimonial_model.dart';
import 'package:my_protfolio/features/shared/data/models/testimonial_data.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  late List<Testimonial> _testimonials;
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _testimonials = TestimonialData.getAllTestimonials();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    if (_testimonials.length <= 1) return;

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % _testimonials.length;
        _pageController.animateToPage(
          nextPage,
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
          Responsive(
            mobile: _buildMobileLayout(context),
            desktop: _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _testimonials.length,
            itemBuilder: (context, index) {
              return _buildTestimonialCard(context, _testimonials[index], true);
            },
          ),
        ),
        SizedBox(height: 20),
        // Page indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_testimonials.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        // Display testimonials in a row like the about section
        SizedBox(
          height: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _testimonials
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

  Widget _buildTestimonialCard(
    BuildContext context,
    Testimonial testimonial,
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
          color: primaryColor.withOpacity(0.18),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(isDark ? 0.12 : 0.06),
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
              color: primaryColor.withOpacity(0.35),
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
                  primaryColor.withOpacity(0.5),
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
                    color: primaryColor.withOpacity(0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.05),
                  image: testimonial.avatarUrl.isNotEmpty
                      ? DecorationImage(
                          image: AssetImage(testimonial.avatarUrl),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: testimonial.avatarUrl.isEmpty
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
                      '${testimonial.role} · ${testimonial.company}',
                      style: TextStyle(
                        fontSize: roleSize,
                        color: primaryColor.withOpacity(0.75),
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
