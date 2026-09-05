import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/translation_model.dart';
import 'package:my_protfolio/features/admin/data/providers/translation_provider.dart';

class TranslationEditDialog extends StatefulWidget {
  final TranslationModel item;
  final TranslationProvider provider;

  const TranslationEditDialog({
    super.key,
    required this.item,
    required this.provider,
  });

  static Future<void> show(
    BuildContext context, {
    required TranslationModel item,
    required TranslationProvider provider,
  }) {
    return showDialog(
      context: context,
      builder: (context) => TranslationEditDialog(
        item: item,
        provider: provider,
      ),
    );
  }

  @override
  State<TranslationEditDialog> createState() => _TranslationEditDialogState();
}

class _TranslationEditDialogState extends State<TranslationEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _enController;
  late final TextEditingController _arController;
  late final TextEditingController _categoryController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _enController = TextEditingController(text: widget.item.en);
    _arController = TextEditingController(text: widget.item.ar);
    _categoryController = TextEditingController(text: widget.item.category);
  }

  @override
  void dispose() {
    _enController.dispose();
    _arController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final updated = widget.item.copyWith(
      en: _enController.text.trim(),
      ar: _arController.text.trim(),
      category: _categoryController.text.trim(),
      updatedAt: DateTime.now(),
    );

    final success = await widget.provider.updateTranslation(updated);
    if (!mounted) return;
    setState(() => _isSaving = false);

    if (success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated "${widget.item.key}" successfully'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.provider.errorMessage ?? 'Failed to update translation'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 700;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 700,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.translate, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Translation',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.item.key,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'monospace',
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // Form fields
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category field
                      TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          hintText: 'e.g. hero, about, technologies',
                          prefixIcon: const Icon(Icons.folder_outlined, size: 20),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Translation inputs
                      if (isDesktop)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildEnglishField(theme)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildArabicField(theme)),
                          ],
                        )
                      else ...[
                        _buildEnglishField(theme),
                        const SizedBox(height: 16),
                        _buildArabicField(theme),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _isSaving ? null : _handleSave,
                    icon: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.save_outlined, size: 18),
                    label: Text(_isSaving ? 'Saving...' : 'Save Translation'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnglishField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🇬🇧', style: TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              'English',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _enController,
          maxLines: 5,
          textDirection: TextDirection.ltr,
          decoration: InputDecoration(
            hintText: 'English text...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'English translation is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildArabicField(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('🇸🇦', style: TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              'العربية (Arabic)',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _arController,
          maxLines: 5,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'النص العربي...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Arabic translation is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
