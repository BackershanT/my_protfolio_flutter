import 'package:flutter/material.dart';

/// Themed snackbar utility for success, error, and info messages.
///
/// Usage:
/// ```dart
/// CustomSnackbar.show(context, message: 'Saved!', type: SnackbarType.success);
/// ```
enum SnackbarType { success, error, info }

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(context);

    Color backgroundColor;
    Color iconColor;
    IconData iconData;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = Colors.green.shade800;
        iconColor = Colors.greenAccent;
        iconData = Icons.check_circle_outline_rounded;
        break;
      case SnackbarType.error:
        backgroundColor = Colors.red.shade800;
        iconColor = Colors.redAccent.shade100;
        iconData = Icons.error_outline_rounded;
        break;
      case SnackbarType.info:
        backgroundColor = theme.primaryColor.withOpacity(0.9);
        iconColor = Colors.white;
        iconData = Icons.info_outline_rounded;
        break;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(iconData, color: iconColor, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: duration,
          dismissDirection: DismissDirection.horizontal,
        ),
      );
  }
}
