import 'package:flutter/material.dart';

/// Form inputs for project links: GitHub, Preview, App Store, Play Store, and Video URL.
class AdminProjectLinksForm extends StatelessWidget {
  final TextEditingController githubController;
  final TextEditingController previewController;
  final TextEditingController appStoreController;
  final TextEditingController playStoreController;
  final TextEditingController videosController;

  const AdminProjectLinksForm({
    super.key,
    required this.githubController,
    required this.previewController,
    required this.appStoreController,
    required this.playStoreController,
    required this.videosController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Project Links & Demonstrations',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),

        // Row 1: GitHub & Live Demo
        Row(
          children: [
            Expanded(
              child: _buildInput(
                controller: githubController,
                label: 'GitHub URL',
                hint: 'https://github.com/username/repo',
                icon: Icons.code_rounded,
                theme: theme,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildInput(
                controller: previewController,
                label: 'Live Preview / Website URL',
                hint: 'https://myproject.com',
                icon: Icons.open_in_new_rounded,
                theme: theme,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Row 2: Play Store & App Store
        Row(
          children: [
            Expanded(
              child: _buildInput(
                controller: playStoreController,
                label: 'Play Store URL',
                hint: 'https://play.google.com/store/apps/...',
                icon: Icons.shop_two_rounded,
                theme: theme,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildInput(
                controller: appStoreController,
                label: 'App Store URL',
                hint: 'https://apps.apple.com/app/...',
                icon: Icons.apple_rounded,
                theme: theme,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Row 3: Video Demo URL
        _buildInput(
          controller: videosController,
          label: 'Video Walkthrough / YouTube / Demo URL',
          hint: 'https://youtube.com/watch?v=... or direct video link',
          icon: Icons.play_circle_outline_rounded,
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.hintColor,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: theme.hintColor.withValues(alpha: 0.4),
              fontSize: 12,
            ),
            prefixIcon: Icon(icon, size: 18, color: theme.hintColor.withValues(alpha: 0.5)),
            filled: true,
            fillColor: theme.cardColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
