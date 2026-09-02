import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_protfolio/features/admin/data/models/testimonial_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/testimonial_repository.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/star_rating_widget.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/featured_toggle_widget.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/avatar_preview_widget.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_text_field.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_form_header.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/testimonial_form_actions.dart';

/// Reusable form dialog for creating and editing testimonials.
///
/// Pass an existing [testimonial] to pre-fill fields for editing.
/// Returns the created/edited [TestimonialModel] on save, or null on cancel.
class TestimonialFormDialog extends StatefulWidget {
  final TestimonialModel? testimonial;

  const TestimonialFormDialog({
    super.key,
    this.testimonial,
  });

  /// Shows the form dialog and returns the result.
  static Future<TestimonialModel?> show(
    BuildContext context, {
    TestimonialModel? testimonial,
  }) async {
    return showGeneralDialog<TestimonialModel?>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return TestimonialFormDialog(testimonial: testimonial);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<TestimonialFormDialog> createState() => _TestimonialFormDialogState();
}

class _TestimonialFormDialogState extends State<TestimonialFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _roleController;
  late final TextEditingController _companyController;
  late final TextEditingController _contentController;
  late final TextEditingController _avatarUrlController;
  late int _rating;
  late bool _isFeatured;
  bool _isUploading = false;
  final _repository = TestimonialRepository();

  bool get _isEditing => widget.testimonial != null;

  @override
  void initState() {
    super.initState();
    final t = widget.testimonial;
    _nameController = TextEditingController(text: t?.name ?? '');
    _roleController = TextEditingController(text: t?.role ?? '');
    _companyController = TextEditingController(text: t?.company ?? '');
    _contentController = TextEditingController(text: t?.content ?? '');
    _avatarUrlController = TextEditingController(text: t?.avatarUrl ?? '');
    _rating = t?.rating ?? 5;
    _isFeatured = t?.isFeatured ?? false;
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      
      if (image != null) {
        setState(() {
          _isUploading = true;
        });

        final bytes = await image.readAsBytes();
        final url = await _repository.uploadAvatar(bytes, image.name);

        setState(() {
          _avatarUrlController.text = url;
          _isUploading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _companyController.dispose();
    _contentController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final result = TestimonialModel(
      id: widget.testimonial?.id,
      name: _nameController.text.trim(),
      role: _roleController.text.trim(),
      company: _companyController.text.trim().isEmpty
          ? null
          : _companyController.text.trim(),
      content: _contentController.text.trim(),
      avatarUrl: _avatarUrlController.text.trim().isEmpty
          ? null
          : _avatarUrlController.text.trim(),
      rating: _rating,
      isFeatured: _isFeatured,
      createdAt: widget.testimonial?.createdAt,
      updatedAt: DateTime.now(),
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isMobile ? double.infinity : 540,
          margin: EdgeInsets.all(isMobile ? 16 : 24),
          constraints: const BoxConstraints(maxHeight: 680),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.dividerColor.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              TestimonialFormHeader(
                isEditing: _isEditing,
                onClose: () => Navigator.of(context).pop(),
              ),
              // Form
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar preview + URL
                        _buildAvatarSection(theme),
                        const SizedBox(height: 20),
                        // Name
                        TestimonialTextField(
                          controller: _nameController,
                          label: 'Full Name',
                          hint: 'e.g. John Doe',
                          icon: Icons.person_outline_rounded,
                          validator: (val) => val == null || val.trim().isEmpty
                              ? 'Name is required'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        // Role
                        TestimonialTextField(
                          controller: _roleController,
                          label: 'Role / Job Title',
                          hint: 'e.g. Senior Developer',
                          icon: Icons.work_outline_rounded,
                          validator: (val) => val == null || val.trim().isEmpty
                              ? 'Role is required'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        // Company
                        TestimonialTextField(
                          controller: _companyController,
                          label: 'Company (Optional)',
                          hint: 'e.g. Google',
                          icon: Icons.business_outlined,
                        ),
                        const SizedBox(height: 16),
                        // Content
                        TestimonialTextField(
                          controller: _contentController,
                          label: 'Testimonial Content',
                          hint: 'Write the testimonial text here...',
                          icon: Icons.format_quote_rounded,
                          maxLines: 4,
                          validator: (val) => val == null || val.trim().isEmpty
                              ? 'Content is required'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        // Rating
                        _buildSectionLabel('Rating', theme),
                        const SizedBox(height: 8),
                        StarRatingWidget(
                          rating: _rating,
                          onRatingChanged: (val) =>
                              setState(() => _rating = val),
                          starSize: 36,
                        ),
                        const SizedBox(height: 20),
                        // Featured toggle
                        FeaturedToggleWidget(
                          isFeatured: _isFeatured,
                          onChanged: (val) =>
                              setState(() => _isFeatured = val),
                        ),
                        const SizedBox(height: 24),
                        // Action buttons
                        TestimonialFormActions(
                          isEditing: _isEditing,
                          onSave: _handleSave,
                          onCancel: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, ThemeData theme) {
    return Text(
      label,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: theme.hintColor,
      ),
    );
  }

  Widget _buildAvatarSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              AvatarPreviewWidget(
                avatarUrl: _avatarUrlController.text,
                name: _nameController.text.isEmpty ? '?' : _nameController.text,
                radius: 40,
              ),
              if (_isUploading)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    iconSize: 18,
                    onPressed: _isUploading ? null : _pickImage,
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    tooltip: 'Upload Avatar',
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
