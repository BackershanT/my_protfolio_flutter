import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/admin_blog_model.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_form_header.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_form_actions.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_image_picker.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/blog/admin_blog_tech_input.dart';

/// Form dialog for creating and editing blog posts.
class AdminBlogFormDialog extends StatefulWidget {
  final AdminBlogModel? blog;

  const AdminBlogFormDialog({
    super.key,
    this.blog,
  });

  static Future<AdminBlogModel?> show(
    BuildContext context, {
    AdminBlogModel? blog,
  }) async {
    return showGeneralDialog<AdminBlogModel?>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AdminBlogFormDialog(blog: blog);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return ScaleTransition(
          scale: curvedAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<AdminBlogFormDialog> createState() => _AdminBlogFormDialogState();
}

class _AdminBlogFormDialogState extends State<AdminBlogFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _dateController;
  late final TextEditingController _timeController;
  late List<String> _technologies;

  bool get _isEditing => widget.blog != null;

  @override
  void initState() {
    super.initState();
    final b = widget.blog;
    final now = DateTime.now();

    final defaultDate = '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final defaultTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    _titleController = TextEditingController(text: b?.title ?? '');
    _descriptionController = TextEditingController(text: b?.description ?? '');
    _imageUrlController = TextEditingController(text: b?.imageUrl ?? '');
    _dateController = TextEditingController(text: b != null && b.date.isNotEmpty ? b.date : defaultDate);
    _timeController = TextEditingController(text: b != null && b.time.isNotEmpty ? b.time : defaultTime);
    _technologies = List.from(b?.technologies ?? []);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime initial = DateTime.tryParse(_dateController.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      final formatted = '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      setState(() {
        _dateController.text = formatted;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formatted = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';
      setState(() {
        _timeController.text = formatted;
      });
    }
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final result = AdminBlogModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _imageUrlController.text.trim(),
      technologies: _technologies,
      date: _dateController.text.trim(),
      time: _timeController.text.trim(),
    );

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 600,
          constraints: const BoxConstraints(maxHeight: 750),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 24, 20, 0),
                child: AdminBlogFormHeader(
                  isEditing: _isEditing,
                  onClose: () => Navigator.of(context).pop(),
                ),
              ),
              const Divider(height: 28),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Article Title *',
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: 'Enter an engaging title...',
                            hintStyle: TextStyle(color: theme.hintColor.withValues(alpha: 0.5), fontSize: 13),
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return 'Title is required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Description / Content
                        Text(
                          'Description & Content *',
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Write the blog post content or excerpt...',
                            hintStyle: TextStyle(color: theme.hintColor.withValues(alpha: 0.5), fontSize: 13),
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return 'Content description is required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Image Picker
                        AdminBlogImagePicker(controller: _imageUrlController),
                        const SizedBox(height: 18),

                        // Technologies & Tags
                        AdminBlogTechInput(
                          initialTechnologies: _technologies,
                          onChanged: (techs) => _technologies = techs,
                        ),
                        const SizedBox(height: 18),

                        // Date & Time row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Publish Date',
                                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _dateController,
                                    readOnly: true,
                                    onTap: _pickDate,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.calendar_today, size: 18),
                                      suffixIcon: const Icon(Icons.arrow_drop_down),
                                      filled: true,
                                      fillColor: theme.cardColor,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Publish Time',
                                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _timeController,
                                    readOnly: true,
                                    onTap: _pickTime,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.access_time, size: 18),
                                      suffixIcon: const Icon(Icons.arrow_drop_down),
                                      filled: true,
                                      fillColor: theme.cardColor,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(20),
                child: AdminBlogFormActions(
                  isEditing: _isEditing,
                  onCancel: () => Navigator.of(context).pop(),
                  onSave: _handleSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
