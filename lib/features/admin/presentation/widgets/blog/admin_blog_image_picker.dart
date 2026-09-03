import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_protfolio/features/admin/data/repositories/admin_blog_repository.dart';

/// Reusable image picker and preview widget for blog posts.
class AdminBlogImagePicker extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onImageUploaded;

  const AdminBlogImagePicker({
    super.key,
    required this.controller,
    this.onImageUploaded,
  });

  @override
  State<AdminBlogImagePicker> createState() => _AdminBlogImagePickerState();
}

class _AdminBlogImagePickerState extends State<AdminBlogImagePicker> {
  bool _isUploading = false;
  final _repository = AdminBlogRepository();

  Future<void> _pickAndUploadImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() => _isUploading = true);

        final bytes = await image.readAsBytes();
        final url = await _repository.uploadCoverImage(bytes, image.name);

        widget.controller.text = url;
        widget.onImageUploaded?.call(url);

        setState(() => _isUploading = false);
      }
    } catch (e) {
      setState(() => _isUploading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = widget.controller.text.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cover Image',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Text field for URL or picker trigger
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Paste image URL or pick from device...',
                  hintStyle: TextStyle(
                    color: theme.hintColor.withValues(alpha: 0.5),
                    fontSize: 13,
                  ),
                  prefixIcon: Icon(
                    Icons.image_outlined,
                    color: theme.hintColor.withValues(alpha: 0.5),
                    size: 20,
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.dividerColor.withValues(alpha: 0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.dividerColor.withValues(alpha: 0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.primaryColor,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: _isUploading ? null : _pickAndUploadImage,
              icon: _isUploading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.upload_file_rounded, size: 18),
              label: Text(_isUploading ? 'Uploading...' : 'Upload'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor.withValues(alpha: 0.12),
                foregroundColor: theme.primaryColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: theme.primaryColor.withValues(alpha: 0.3)),
                ),
              ),
            ),
          ],
        ),

        // Image Preview Thumbnail
        if (hasImage) ...[
          const SizedBox(height: 12),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.2),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                widget.controller.text.startsWith('http')
                    ? Image.network(
                        widget.controller.text,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildErrorPlaceholder(theme),
                      )
                    : Image.asset(
                        widget.controller.text,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildErrorPlaceholder(theme),
                      ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton.filled(
                    onPressed: () {
                      widget.controller.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.close, size: 16),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black54,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(6),
                    ),
                    tooltip: 'Remove image',
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildErrorPlaceholder(ThemeData theme) {
    return Container(
      color: theme.cardColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.broken_image_rounded, size: 36, color: theme.hintColor),
            const SizedBox(height: 4),
            Text(
              'Invalid image URL',
              style: TextStyle(color: theme.hintColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
