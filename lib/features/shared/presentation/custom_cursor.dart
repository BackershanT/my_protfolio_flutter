import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/core/providers/cursor_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomCursor extends StatelessWidget {
  final Widget child;

  const CustomCursor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Only show custom cursor on Web for better UX
    if (!kIsWeb) return child;

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (event) {
        context.read<CursorProvider>().updatePosition(event.localPosition);
      },
      child: Stack(
        children: [
          child,
          Consumer<CursorProvider>(
            builder: (context, provider, _) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 50),
                left:
                    provider.pointerPosition.dx -
                    (provider.isHovering ? 25 : 15),
                top:
                    provider.pointerPosition.dy -
                    (provider.isHovering ? 25 : 15),
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: provider.isHovering ? 50 : 30,
                    height: provider.isHovering ? 50 : 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryLight.withOpacity(0.5),
                        width: 1.5,
                      ),
                      color: AppColors.primaryLight.withOpacity(0.1),
                    ),
                  ),
                ),
              );
            },
          ),
          Consumer<CursorProvider>(
            builder: (context, provider, _) {
              return Positioned(
                left: provider.pointerPosition.dx - 4,
                top: provider.pointerPosition.dy - 4,
                child: IgnorePointer(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Extension to easily wrap widgets with hover detection
extension HoverExtension on Widget {
  Widget withCursorHover(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => context.read<CursorProvider>().setHovering(true),
      onExit: (_) => context.read<CursorProvider>().setHovering(false),
      child: this,
    );
  }
}
