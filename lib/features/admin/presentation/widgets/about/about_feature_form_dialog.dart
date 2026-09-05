import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/about_feature_model.dart';

class AboutFeatureFormDialog extends StatefulWidget {
  final AboutFeatureModel? feature;

  const AboutFeatureFormDialog({super.key, this.feature});

  static Future<AboutFeatureModel?> show(
    BuildContext context, {
    AboutFeatureModel? feature,
  }) {
    return showDialog<AboutFeatureModel?>(
      context: context,
      builder: (context) => AboutFeatureFormDialog(feature: feature),
    );
  }

  @override
  State<AboutFeatureFormDialog> createState() => _AboutFeatureFormDialogState();
}

class _AboutFeatureFormDialogState extends State<AboutFeatureFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final TextEditingController _orderController;
  late String _selectedIconName;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.feature?.title ?? '');
    _descController = TextEditingController(text: widget.feature?.description ?? '');
    _orderController = TextEditingController(
      text: (widget.feature?.sortOrder ?? 1).toString(),
    );
    _selectedIconName = widget.feature?.iconName ?? 'phone_android';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final result = AboutFeatureModel(
        id: widget.feature?.id ?? '',
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        iconName: _selectedIconName,
        sortOrder: int.tryParse(_orderController.text.trim()) ?? 0,
      );
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.feature != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Feature Card' : 'Add Feature Card'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 500,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Feature Title *',
                    hintText: 'e.g. Mobile & Cross-Platform Apps',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Description
                TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description *',
                    hintText: 'Brief summary of your specialization...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Icon Selection Label
                Text(
                  'Select Card Icon:',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Icon Chips Wrap
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: AboutFeatureModel.availableIcons.map((item) {
                    final iconName = item['name'] as String;
                    final iconData = item['icon'] as IconData;
                    final label = item['label'] as String;
                    final isSelected = _selectedIconName == iconName;

                    return ChoiceChip(
                      avatar: Icon(
                        iconData,
                        size: 18,
                        color: isSelected ? Colors.white : theme.colorScheme.primary,
                      ),
                      label: Text(label),
                      selected: isSelected,
                      selectedColor: theme.colorScheme.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                        fontSize: 12,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedIconName = iconName;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // Sort Order
                TextFormField(
                  controller: _orderController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Sort Order (Position)',
                    hintText: 'e.g. 1, 2, 3',
                    border: OutlineInputBorder(),
                    helperText: 'Lower numbers appear first',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(isEditing ? 'Update Card' : 'Create Card'),
        ),
      ],
    );
  }
}
