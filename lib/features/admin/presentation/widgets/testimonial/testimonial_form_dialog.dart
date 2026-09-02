import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/testimonial_model.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/star_rating_widget.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/featured_toggle_widget.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/testimonial/avatar_preview_widget.dart';

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
              _buildDialogHeader(theme),
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
                        _buildField(
                          controller: _nameController,
                          label: 'Full Name',
                          hint: 'e.g. John Doe',
                          icon: Icons.person_outline_rounded,
                          validator: (val) => val == null || val.trim().isEmpty
                              ? 'Name is required'
                              : null,
                          theme: theme,
                        ),
                        const SizedBox(height: 16),
                        // Role
                        _buildField(
                          controller: _roleController,
                          label: 'Role / Job Title',
                          hint: 'e.g. Senior Developer',
                          icon: Icons.work_outline_rounded,
                          validator: (val) => val == null || val.trim().isEmpty
                              ? 'Role is required'
                              : null,
                          theme: theme,
                        ),
                        const SizedBox(height: 16),
                        // Company
                        _buildField(
                          controller: _companyController,
                          label: 'Company (Optional)',
                          hint: 'e.g. Google',
                          icon: Icons.business_outlined,
                          theme: theme,
                        ),
                        const SizedBox(height: 16),
                        // Content
                        _buildField(
                          controller: _contentController,
                          label: 'Testimonial Content',
                          hint: 'Write the testimonial text here...',
                          icon: Icons.format_quote_rounded,
                          maxLines: 4,
                          validator: (val) => val == null || val.trim().isEmpty
                              ? 'Content is required'
                              : null,
                          theme: theme,
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
                        _buildActions(theme),
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

  Widget _buildDialogHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _isEditing ? Icons.edit_rounded : Icons.add_rounded,
              color: theme.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _isEditing ? 'Edit Testimonial' : 'Add New Testimonial',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close_rounded, color: theme.hintColor),
            style: IconButton.styleFrom(
              backgroundColor: theme.dividerColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Center(
          child: AvatarPreviewWidget(
            avatarUrl: _avatarUrlController.text,
            name: _nameController.text.isEmpty ? '?' : _nameController.text,
            radius: 36,
          ),
        ),
        const SizedBox(height: 12),
        _buildField(
          controller: _avatarUrlController,
          label: 'Avatar URL (Optional)',
          hint: 'https://example.com/avatar.jpg',
          icon: Icons.link_rounded,
          onChanged: (_) => setState(() {}),
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required ThemeData theme,
    String? Function(String?)? validator,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      onChanged: onChanged,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        labelStyle: TextStyle(color: theme.hintColor, fontSize: 14),
        hintStyle: TextStyle(
          color: theme.hintColor.withOpacity(0.4),
          fontSize: 13,
        ),
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 14 : 0,
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

  Widget _buildActions(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: theme.dividerColor.withOpacity(0.3)),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: _handleSave,
            icon: Icon(
              _isEditing ? Icons.save_rounded : Icons.add_rounded,
              size: 20,
            ),
            label: Text(
              _isEditing ? 'Update' : 'Add Testimonial',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
