import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/shared/data/models/certification_model.dart';
import 'package:my_protfolio/features/shared/data/models/certification_data.dart';

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({super.key});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  late List<Certification> _certifications;
  PageController? _pageController;
  int _currentPage = 0;
  Timer? _timer;
  double _lastViewportFraction = 0.85;
  bool _isReversing = false;

  @override
  void initState() {
    super.initState();
    _certifications = CertificationData.getAllCertifications();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isDesktop = Responsive.isDesktop(context);
    final currentFraction = isDesktop ? 0.333 : 0.85;

    if (_pageController == null || _lastViewportFraction != currentFraction) {
      _pageController?.dispose();
      _lastViewportFraction = currentFraction;
      _pageController = PageController(
        viewportFraction: currentFraction,
        initialPage: _currentPage,
      );

      // Stop existing timer and start a fresh one
      _timer?.cancel();
      // Use a small delay to ensure PageView is built and controller is attached
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _startAutoScroll();
      });
    }
  }

  void _startAutoScroll() {
    if (_certifications.length <= 1) return;
    _timer?.cancel(); // Safety check

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController != null && _pageController!.hasClients) {
        int nextPage;
        if (!_isReversing) {
          if (_currentPage < _certifications.length - 1) {
            nextPage = _currentPage + 1;
          } else {
            _isReversing = true;
            nextPage = _currentPage - 1;
          }
        } else {
          if (_currentPage > 0) {
            nextPage = _currentPage - 1;
          } else {
            _isReversing = false;
            nextPage = _currentPage + 1;
          }
        }

        _pageController!.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutBack,
        );
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  void _showCertificatePopup(Certification cert) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                maxWidth: 1000,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: const EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 4,
                  child: Image.asset(
                    cert.certificateUrl ?? cert.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              cert.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              cert.authority,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack).fadeIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile =
        Responsive.isMobile(context) || Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(title: AppTexts.certificationsTitle),
          const SizedBox(height: 50),
          SizedBox(
            height: isDesktop ? 450 : 400,
            child: PageView.builder(
              controller: _pageController,
              clipBehavior: Clip.none,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
                _resetTimer();
              },
              itemCount: _certifications.length,
              itemBuilder: (context, index) {
                return _buildCertificationCard(
                  _certifications[index],
                  index,
                  isDesktop,
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          // Progress indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_certifications.length, (index) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? (isDark ? Colors.white : const Color(0xFF0F172A))
                      : (isDark ? Colors.white24 : Colors.black12),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationCard(
    Certification cert,
    int index,
    bool isDesktop,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _pageController!,
      builder: (context, child) {
        double value = 1.0;
        if (_pageController!.position.haveDimensions) {
          value = _pageController!.page! - index;
          double scaleFactor = isDesktop ? 0.05 : 0.15;
          value = (1 - (value.abs() * scaleFactor)).clamp(0.0, 1.0);
        }
        return Center(
          child: Transform.scale(
            scale: value,
            child: Opacity(
              opacity: (value * value).clamp(0.5, 1.0),
              child: child,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo/Image at the top
            Expanded(
              flex: 2,
              child: Center(
                child: Hero(
                  tag: 'cert_${cert.name}_$index',
                  child: Image.asset(
                    cert.imageUrl,
                    height: isDesktop ? 80 : 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Certification Name
            Text(
              cert.name,
              style: TextStyle(
                fontSize: isDesktop ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 10),
            // Authority and Date
            Text(
              '${cert.authority} · ${cert.date}',
              style: TextStyle(
                fontSize: isDesktop ? 16 : 14,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 30),
            // View Credential Button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _showCertificatePopup(cert),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF64FFDA,
                    ), // Bright teal/cyan from mockup
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF64FFDA).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'viewCredential'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          0xFF0A192F,
                        ), // Dark navy text matching theme
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 400.ms).scale(duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
