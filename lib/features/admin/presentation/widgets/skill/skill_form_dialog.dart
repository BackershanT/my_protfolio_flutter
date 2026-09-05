import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/skill_repository.dart';

class SkillFormDialog extends StatefulWidget {
  final SkillModel? skill;

  const SkillFormDialog({
    super.key,
    this.skill,
  });

  static Future<SkillModel?> show(
    BuildContext context, {
    SkillModel? skill,
  }) async {
    return showGeneralDialog<SkillModel?>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SkillFormDialog(skill: skill);
      },
    );
  }

  @override
  State<SkillFormDialog> createState() => _SkillFormDialogState();
}

class _SkillFormDialogState extends State<SkillFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _iconUrlController;
  bool _isUploading = false;
  final _repository = SkillRepository();

  bool get _isEditing => widget.skill != null;

  @override
  void initState() {
    super.initState();
    final s = widget.skill;
    _nameController = TextEditingController(text: s?.name ?? '');
    _iconUrlController = TextEditingController(text: s?.image ?? '');
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
        final url = await _repository.uploadIcon(bytes, image.name);

        setState(() {
          _iconUrlController.text = url;
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
    _iconUrlController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) return;

    final result = SkillModel(
      id: widget.skill?.id,
      name: _nameController.text.trim(),
      image: _iconUrlController.text.trim(),
      createdAt: widget.skill?.createdAt,
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
          width: isMobile ? double.infinity : 400,
          margin: EdgeInsets.all(isMobile ? 16 : 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.1),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEditing ? 'Edit Skill' : 'Add New Skill',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                // Icon preview + URL
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: _iconUrlController.text.isNotEmpty 
                            ? Image.network(
                                _iconUrlController.text,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                              )
                            : const Icon(Icons.image, size: 30),
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
                            tooltip: 'Upload Icon',
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Name
                TextFormField(
                  controller: _nameController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Name is required' : null,
                  decoration: const InputDecoration(
                    labelText: 'Skill Name',
                    hintText: 'e.g. Flutter',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Custom Icon Url field just in case they want to paste one
                TextFormField(
                  controller: _iconUrlController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Icon URL is required' : null,
                  decoration: const InputDecoration(
                    labelText: 'Icon URL',
                    hintText: 'https://...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _handleSave,
                      child: Text(_isEditing ? 'Update' : 'Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
