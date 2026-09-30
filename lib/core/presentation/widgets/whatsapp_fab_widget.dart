import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_protfolio/core/config/whatsapp_config.dart';

class WhatsAppFabWidget extends StatefulWidget {
  const WhatsAppFabWidget({super.key});

  @override
  State<WhatsAppFabWidget> createState() => _WhatsAppFabWidgetState();
}

class _WhatsAppFabWidgetState extends State<WhatsAppFabWidget>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const whatsappColor = Color(0xFF25D366);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => WhatsAppConfig.launchWhatsApp(),
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            final scalePulse = 1.0 + (_pulseController.value * 0.08);

            return Transform.scale(
              scale: _isHovered ? 1.1 : scalePulse,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                  horizontal: _isHovered ? 16 : 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: whatsappColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: whatsappColor.withValues(
                        alpha: 0.35 + (_pulseController.value * 0.25),
                      ),
                      blurRadius: _isHovered ? 24 : 14 + (_pulseController.value * 8),
                      spreadRadius: _isHovered ? 4 : 2 + (_pulseController.value * 4),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 26,
                    ),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 200),
                      crossFadeState: _isHovered
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: const Text(
                          'Chat on WhatsApp',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).scale(
          begin: const Offset(0.7, 0.7),
          curve: Curves.elasticOut,
          duration: 800.ms,
        );
  }
}
