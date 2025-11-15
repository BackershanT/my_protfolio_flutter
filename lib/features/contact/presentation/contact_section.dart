import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_protfolio/features/shared/core/constants/app_texts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/utils/responsive.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:my_protfolio/features/contact/data/repositories/contact_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _contactRepository = ContactRepository();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      try {
        await _contactRepository.sendMessage(
          name: _nameController.text,
          email: _emailController.text,
          message: _messageController.text,
        );

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Message sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          // Clear form
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      } catch (e) {
        print('Error sending message: $e');
        // Show user-friendly error message
        String errorMessage = 'Failed to send message. ';

        // Provide more specific error messages based on the error type
        if (e.toString().contains('timeout')) {
          errorMessage +=
              'Request timed out. This usually means the Firebase configuration is incorrect or the Firestore database rules don\'t allow writes. Please verify your Firebase setup and database rules.';
        } else if (e.toString().contains('permission-denied')) {
          errorMessage +=
              'Permission denied. Please check your Firestore database rules at the Firebase Console.';
        } else if (e.toString().contains('unauthenticated')) {
          errorMessage +=
              'Authentication required. Please check your Firebase configuration at the Firebase Console.';
        } else if (e.toString().contains('unavailable')) {
          errorMessage +=
              'Service unavailable. Please check your internet connection and try again later.';
        } else if (e.toString().contains('Firebase')) {
          errorMessage +=
              'Please check your Firebase configuration and internet connection. You may need to set up Firestore database rules.';
        } else {
          errorMessage +=
              'Please try again later. If the problem persists, check your internet connection and Firebase setup.';
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 8),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSending = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth < 850 ? 20 : (screenWidth < 1200 ? 40 : 100),
        vertical: screenWidth < 850 ? 60 : 100,
      ),
      child: Column(
        children: [
          SectionTitle(
            title: AppTexts.contactTitle,
            subtitle: AppTexts.contactDescription,
          ),
          SizedBox(height: screenWidth < 850 ? 40 : 50),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactForm(context),
        const SizedBox(height: 50),
        _buildSocialLinks(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth < 1400 ? 60.0 : 80.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildContactForm(context)),
        SizedBox(width: spacing),
        Expanded(flex: 2, child: _buildSocialLinks(context)),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Name Field
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: AppTexts.contactNameHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.primaryLight
                      : AppColors.primaryDark,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          const SizedBox(height: 20),
          // Email Field
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: AppTexts.contactEmailHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.primaryLight
                      : AppColors.primaryDark,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
          const SizedBox(height: 20),
          // Message Field
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: AppTexts.contactMessageHint,
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.borderRadiusMedium),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.primaryLight
                      : AppColors.primaryDark,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
          const SizedBox(height: 30),
          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSending ? null : _submitForm,
              child: _isSending
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(AppTexts.contactSendButton),
            ),
          ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;

    final socialLinks = [
      SocialLink(
        icon: FontAwesomeIcons.linkedin,
        color: AppColors.linkedIn,
        url: 'https://www.linkedin.com/in/backershan-t-166aa078/',
      ),
      SocialLink(
        icon: FontAwesomeIcons.github,
        color: AppColors.github,
        url: 'https://github.com/BackershanT',
      ),
      SocialLink(
        icon: FontAwesomeIcons.instagram,
        color: Color(0xFFE1306C),
        url: 'https://www.instagram.com/backershan.t.2025/',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Connect with me:',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 18 : 20,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
        ),
        SizedBox(height: isMobile ? 20 : 30),
        // Display social links centered in a horizontal row
        Center(
          child: Wrap(
            spacing: isMobile ? 16 : 20,
            runSpacing: isMobile ? 16 : 20,
            alignment: WrapAlignment.center,
            children: List.generate(
              socialLinks.length,
              (index) => socialLinks[index]
                  .animate()
                  .fadeIn(delay: (400 + (index * 150)).ms, duration: 600.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    duration: 600.ms,
                    curve: Curves.easeOutBack,
                    delay: (400 + (index * 150)).ms,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class SocialLink extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String url;

  const SocialLink({
    super.key,
    required this.icon,
    required this.color,
    required this.url,
  });

  @override
  State<SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<SocialLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final size = isMobile ? 56.0 : 64.0;
    final iconSize = isMobile ? 24.0 : 28.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final Uri uri = Uri.parse(widget.url);
          if (!await launchUrl(uri)) {
            throw Exception('Could not launch ${widget.url}');
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: size,
          width: size,
          transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
          decoration: BoxDecoration(
            gradient: _isHovered
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [widget.color, widget.color.withValues(alpha: 0.7)],
                  )
                : null,
            color: !_isHovered ? widget.color : null,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: _isHovered ? 0.4 : 0.3),
                blurRadius: _isHovered ? 20 : 12,
                offset: Offset(0, _isHovered ? 8 : 4),
                spreadRadius: _isHovered ? 2 : 0,
              ),
            ],
          ),
          child: Icon(widget.icon, color: Colors.white, size: iconSize),
        ),
      ),
    );
  }
}
