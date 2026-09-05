import 'package:flutter/material.dart';

/// Interactive chip input widget for managing project technologies/stack.
class AdminProjectTechInput extends StatefulWidget {
  final List<String> initialTechnologies;
  final ValueChanged<List<String>> onChanged;

  const AdminProjectTechInput({
    super.key,
    required this.initialTechnologies,
    required this.onChanged,
  });

  @override
  State<AdminProjectTechInput> createState() => _AdminProjectTechInputState();
}

class _AdminProjectTechInputState extends State<AdminProjectTechInput> {
  late final List<String> _technologies;
  final TextEditingController _controller = TextEditingController();

  static const List<String> _popularSuggestions = [
    'Flutter',
    'Dart',
    'Bloc',
    'Riverpod',
    'Provider',
    'Firebase',
    'Supabase',
    'REST API',
    'GraphQL',
    'Clean Architecture',
    'SQLite',
    'Socket.IO',
    'Stripe',
  ];

  @override
  void initState() {
    super.initState();
    _technologies = List.from(widget.initialTechnologies);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTechnology(String tech) {
    final trimmed = tech.trim();
    if (trimmed.isEmpty) return;
    if (!_technologies.any((t) => t.toLowerCase() == trimmed.toLowerCase())) {
      setState(() {
        _technologies.add(trimmed);
      });
      widget.onChanged(_technologies);
    }
    _controller.clear();
  }

  void _removeTechnology(String tech) {
    setState(() {
      _technologies.remove(tech);
    });
    widget.onChanged(_technologies);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technologies & Tech Stack *',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),

        // Input row
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: _addTechnology,
                decoration: InputDecoration(
                  hintText: 'Type technology (e.g. Flutter, Bloc) and press +...',
                  hintStyle: TextStyle(
                    color: theme.hintColor.withValues(alpha: 0.5),
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: theme.cardColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: () => _addTechnology(_controller.text),
              icon: const Icon(Icons.add, size: 20),
              style: IconButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              tooltip: 'Add Tag',
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Added Chips
        if (_technologies.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: _technologies.map((tech) {
              return Chip(
                label: Text(tech),
                deleteIcon: const Icon(Icons.close, size: 14),
                onDeleted: () => _removeTechnology(tech),
                backgroundColor: theme.primaryColor.withValues(alpha: 0.12),
                labelStyle: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                side: BorderSide(color: theme.primaryColor.withValues(alpha: 0.25)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }).toList(),
          )
        else
          Text(
            'No technologies added yet. Add at least one to describe your stack.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor.withValues(alpha: 0.7),
              fontStyle: FontStyle.italic,
            ),
          ),

        const SizedBox(height: 8),

        // Quick suggestions
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                'Suggestions: ',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                  fontSize: 11,
                ),
              ),
              ..._popularSuggestions.map((suggestion) {
                final alreadyAdded = _technologies.contains(suggestion);
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ActionChip(
                    label: Text(suggestion),
                    onPressed: alreadyAdded ? null : () => _addTechnology(suggestion),
                    backgroundColor: alreadyAdded
                        ? theme.disabledColor.withValues(alpha: 0.05)
                        : theme.cardColor,
                    labelStyle: TextStyle(
                      fontSize: 11,
                      color: alreadyAdded
                          ? theme.disabledColor
                          : theme.textTheme.bodyMedium?.color,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
