import 'package:flutter/material.dart';

class AdminProjectTypesSelector extends StatelessWidget {
  final List<String> types;
  final List<String> presetProjectTypes;
  final TextEditingController customTypeController;
  final Function(VoidCallback fn) setState;

  const AdminProjectTypesSelector({
    super.key,
    required this.types,
    required this.presetProjectTypes,
    required this.customTypeController,
    required this.setState,
  });

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
              'Project Type / Categories *',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              'Select one or more',
              style: TextStyle(fontSize: 12, color: theme.hintColor),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...presetProjectTypes.map((type) {
              final isSelected = types.any((t) => t.toLowerCase() == type.toLowerCase());
              return FilterChip(
                label: Text(type),
                selected: isSelected,
                selectedColor: theme.primaryColor.withValues(alpha: 0.2),
                checkmarkColor: theme.primaryColor,
                labelStyle: TextStyle(
                  color: isSelected ? theme.primaryColor : theme.textTheme.bodyMedium?.color,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
                side: BorderSide(
                  color: isSelected ? theme.primaryColor : theme.dividerColor.withValues(alpha: 0.3),
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      if (!types.any((t) => t.toLowerCase() == type.toLowerCase())) {
                        types.add(type);
                      }
                    } else {
                      types.removeWhere((t) => t.toLowerCase() == type.toLowerCase());
                    }
                  });
                },
              );
            }),
            ...types.where((t) => !presetProjectTypes.any((p) => p.toLowerCase() == t.toLowerCase())).map((customType) {
              return Chip(
                label: Text(customType),
                deleteIcon: const Icon(Icons.close, size: 14),
                onDeleted: () {
                  setState(() {
                    types.remove(customType);
                  });
                },
                backgroundColor: theme.primaryColor.withValues(alpha: 0.15),
                labelStyle: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              );
            }),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: customTypeController,
                decoration: InputDecoration(
                  hintText: 'Add custom type (e.g. AI / Web3)...',
                  isDense: true,
                  filled: true,
                  fillColor: theme.cardColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onFieldSubmitted: (val) {
                  final trimmed = val.trim();
                  if (trimmed.isNotEmpty && !types.any((t) => t.toLowerCase() == trimmed.toLowerCase())) {
                    setState(() {
                      types.add(trimmed);
                      customTypeController.clear();
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {
                final trimmed = customTypeController.text.trim();
                if (trimmed.isNotEmpty && !types.any((t) => t.toLowerCase() == trimmed.toLowerCase())) {
                  setState(() {
                    types.add(trimmed);
                    customTypeController.clear();
                  });
                }
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
