import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/admin_project_model.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_form_header.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_form_actions.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_image_picker.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_screenshots_picker.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_links_form.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_tech_input.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_ai_suggest_sheet.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/ai_suggest_button.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/admin_project_types_selector.dart';

/// Form dialog for creating and editing projects.
class AdminProjectFormDialog extends StatefulWidget {
  final AdminProjectModel? project;

  const AdminProjectFormDialog({
    super.key,
    this.project,
  });

  static Future<AdminProjectModel?> show(
    BuildContext context, {
    AdminProjectModel? project,
  }) async {
    return showGeneralDialog<AdminProjectModel?>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AdminProjectFormDialog(project: project);
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
  State<AdminProjectFormDialog> createState() => _AdminProjectFormDialogState();
}

class _AdminProjectFormDialogState extends State<AdminProjectFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _companyController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _readmeController;
  late final TextEditingController _githubController;
  late final TextEditingController _previewController;
  late final TextEditingController _appStoreController;
  late final TextEditingController _playStoreController;
  late final TextEditingController _videosController;
  late final TextEditingController _customTypeController;

  late List<String> _technologies;
  late List<String> _screenshots;
  late List<String> _types;

  static const List<String> _presetProjectTypes = [
    'Website',
    'Mobile',
    'Full Stack',
    'Flutter',
    'React',
    'Next.js',
  ];

  bool get _isEditing => widget.project != null;

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _nameController = TextEditingController(text: p?.name ?? '');
    _companyController = TextEditingController(text: p?.companyName ?? '');
    _descriptionController = TextEditingController(text: p?.description ?? '');
    _imageUrlController = TextEditingController(text: p?.imageUrl ?? '');
    _readmeController = TextEditingController(text: p?.readMe ?? '');
    _githubController = TextEditingController(text: p?.githubUrl ?? '');
    _previewController = TextEditingController(text: p?.previewUrl ?? '');
    _appStoreController = TextEditingController(text: p?.appStoreUrl ?? '');
    _playStoreController = TextEditingController(text: p?.playStoreUrl ?? '');
    _videosController = TextEditingController(text: p?.videosUrl ?? '');
    _customTypeController = TextEditingController();
    _technologies = List.from(p?.technologies ?? []);
    _screenshots = List.from(p?.screenshots ?? []);
    _types = List.from(p?.types.isNotEmpty == true ? p!.types : ['Website']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _readmeController.dispose();
    _githubController.dispose();
    _previewController.dispose();
    _appStoreController.dispose();
    _playStoreController.dispose();
    _videosController.dispose();
    _customTypeController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final selectedTypes = _types.isEmpty ? ['Website'] : _types;

    final result = AdminProjectModel(
      name: _nameController.text.trim(),
      companyName: _companyController.text.trim(),
      imageUrl: _imageUrlController.text.trim(),
      description: _descriptionController.text.trim(),
      technologies: _technologies,
      readMe: _readmeController.text.trim(),
      githubUrl: _githubController.text.trim(),
      previewUrl: _previewController.text.trim(),
      appStoreUrl: _appStoreController.text.trim(),
      playStoreUrl: _playStoreController.text.trim(),
      screenshots: _screenshots,
      videosUrl: _videosController.text.trim(),
      projectType: selectedTypes.first,
      types: selectedTypes,
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
          width: 680,
          constraints: const BoxConstraints(maxHeight: 800),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.14),
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
                child: AdminProjectFormHeader(
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
                        // Name & Company Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Project Name *',
                                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      hintText: 'e.g. HealthTracker App',
                                      filled: true,
                                      fillColor: theme.cardColor,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) return 'Project name is required';
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Company / Client',
                                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _companyController,
                                    decoration: InputDecoration(
                                      hintText: 'e.g. Freelance, Acme Inc',
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
                        const SizedBox(height: 18),

                        // Project Types
                        AdminProjectTypesSelector(
                          types: _types,
                          presetProjectTypes: _presetProjectTypes,
                          customTypeController: _customTypeController,
                          setState: setState,
                        ),
                        const SizedBox(height: 18),

                        // Overview Description
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Project Overview Description *',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            AiSuggestButton(
                              onPressed: () {
                                AdminAiSuggestSheet.show(
                                  context,
                                  projectName: _nameController.text.trim(),
                                  technologies: _technologies,
                                  types: _types,
                                  companyName: _companyController.text.trim(),
                                  onAccept: (desc) {
                                    setState(() {
                                      _descriptionController.text = desc;
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'A concise summary of what this project accomplishes...',
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) return 'Description is required';
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        // Cover Image Picker
                        AdminProjectImagePicker(controller: _imageUrlController),
                        const SizedBox(height: 18),

                        // Technologies Input
                        AdminProjectTechInput(
                          initialTechnologies: _technologies,
                          onChanged: (techs) => _technologies = techs,
                        ),
                        const SizedBox(height: 18),

                        // Screenshots Gallery Picker
                        AdminProjectScreenshotsPicker(
                          initialScreenshots: _screenshots,
                          onChanged: (shots) => _screenshots = shots,
                        ),
                        const SizedBox(height: 18),

                        // Links Row
                        AdminProjectLinksForm(
                          githubController: _githubController,
                          previewController: _previewController,
                          appStoreController: _appStoreController,
                          playStoreController: _playStoreController,
                          videosController: _videosController,
                        ),
                        const SizedBox(height: 18),

                        // Readme Markdown Content
                        Text(
                          'Detailed README / Case Study (Markdown)',
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _readmeController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: '# Architecture & Features\n\nExplain key challenges solved...',
                            filled: true,
                            fillColor: theme.cardColor,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
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
                child: AdminProjectFormActions(
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
