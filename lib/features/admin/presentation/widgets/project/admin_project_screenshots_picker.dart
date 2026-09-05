import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_protfolio/features/admin/data/repositories/admin_project_repository.dart';

/// Multi-screenshot uploader and gallery editor for projects.
class AdminProjectScreenshotsPicker extends StatefulWidget {
  final List<String> initialScreenshots;
  final ValueChanged<List<String>> onChanged;

  const AdminProjectScreenshotsPicker({
    super.key,
    required this.initialScreenshots,
    required this.onChanged,
  });

  @override
  State<AdminProjectScreenshotsPicker> createState() => _AdminProjectScreenshotsPickerState();
}

class _AdminProjectScreenshotsPickerState extends State<AdminProjectScreenshotsPicker> {
  late final List<String> _screenshots;
  bool _isUploading = false;
  String? _uploadProgress;
  final _repository = AdminProjectRepository();
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _screenshots = List.from(widget.initialScreenshots);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadScreenshots() async {
    try {
      final picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage(imageQuality: 85);

      if (images.isNotEmpty) {
        setState(() {
          _isUploading = true;
          _uploadProgress = 'Uploading (0/${images.length})...';
        });

        int uploaded = 0;
        final List<String> newUrls = [];

        for (final image in images) {
          final bytes = await image.readAsBytes();
          final url = await _repository.uploadScreenshot(bytes, image.name);
          newUrls.add(url);
          uploaded++;
          if (mounted) {
            setState(() {
              _uploadProgress = 'Uploading ($uploaded/${images.length})...';
            });
          }
        }

        if (mounted) {
          setState(() {
            _screenshots.addAll(newUrls);
            _isUploading = false;
            _uploadProgress = null;
          });
          widget.onChanged(_screenshots);
        }
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
        _uploadProgress = null;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload screenshots: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _addByUrl() {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;
    setState(() {
      _screenshots.add(url);
    });
    _urlController.clear();
    widget.onChanged(_screenshots);
  }

  void _removeScreenshot(int index) {
    setState(() {
      _screenshots.removeAt(index);
    });
    widget.onChanged(_screenshots);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Project Screenshots (${_screenshots.length})',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _isUploading ? null : _pickAndUploadScreenshots,
              icon: _isUploading
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.add_photo_alternate_rounded, size: 16),
              label: Text(_isUploading ? (_uploadProgress ?? 'Uploading...') : 'Upload Images'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor.withValues(alpha: 0.12),
                foregroundColor: theme.primaryColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Add by URL option
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  hintText: 'Or paste screenshot image URL...',
                  hintStyle: TextStyle(
                    color: theme.hintColor.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: _addByUrl,
              icon: const Icon(Icons.add, size: 20),
              tooltip: 'Add URL',
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Thumbnails gallery
        if (_screenshots.isNotEmpty)
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _screenshots.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final url = _screenshots[index];
                return Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      url.startsWith('http')
                          ? Image.network(
                              url,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(Icons.broken_image, size: 24, color: Colors.grey),
                              ),
                            )
                          : Image.asset(
                              url,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(Icons.broken_image, size: 24, color: Colors.grey),
                              ),
                            ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeScreenshot(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.close, size: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        else
          Text(
            'No screenshots added yet.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor.withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }
}
