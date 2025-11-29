import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
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

    // Card dimensions matching about section cards: 280px on mobile and 350px on desktop
    final cardWidth = isMobile ? 280.0 : 350.0;
    final padding = isMobile ? 20.0 : (screenWidth < 1200 ? 24.0 : 30.0);
    final contentSize = isMobile ? 14.0 : 16.0;
    final nameSize = isMobile ? 18.0 : 20.0;
    final roleSize = isMobile ? 14.0 : 16.0;

    Widget card = Container(
      width: isMobile
          ? cardWidth
          : null, // No width constraint for desktop (Expanded will handle it)
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Client info (avatar, name, role, company) - ABOVE content
          Row(
            children: [
              // Avatar with image
              Container(
                width: isMobile ? 50 : 60,
                height: isMobile ? 50 : 60,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(30),
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
                        size: isMobile ? 24 : 30,
                        color: isDark ? Colors.white70 : Colors.black54,
                      )
                    : null,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.name,
                      style: TextStyle(
                        fontSize: nameSize,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                    SizedBox(height: 4),
                    Text(
                      '${testimonial.role}',
                      style: TextStyle(
                        fontSize: roleSize - 2,
                        color: isDark
                            ? Colors.white70
                            : Colors.black.withOpacity(0.7),
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                    SizedBox(height: 2),
                    Text(
                      ' ${testimonial.company}',
                      style: TextStyle(
                        fontSize: roleSize,
                        color: isDark
                            ? Colors.white70
                            : Colors.black.withOpacity(0.7),
                      ),
                    ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 20 : 30),

          // Testimonial content - BELOW client info
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                testimonial.content,
                style: TextStyle(
                  fontSize: contentSize,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ).animate().fadeIn(duration: 600.ms),
            ),
          ),
        ],
      ),
    );

    // For mobile, we wrap in a container with specific width and margin
    if (isMobile) {
      return Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 20),
        child: card,
      );
    } else {
      // For desktop, we just return the card as Expanded will handle sizing
      return card;
    }
  }
}
