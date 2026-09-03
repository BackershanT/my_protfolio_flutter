import 'package:flutter/material.dart';

/// Styled search bar and technology filter chip row for blogs.
class AdminBlogSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onTechnologySelected;
  final String initialSearch;
  final String? selectedTechnology;
  final List<String> availableTechnologies;

  const AdminBlogSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onTechnologySelected,
    this.initialSearch = '',
    this.selectedTechnology,
    this.availableTechnologies = const [],
  });

  @override
  State<AdminBlogSearchBar> createState() => _AdminBlogSearchBarState();
}

class _AdminBlogSearchBarState extends State<AdminBlogSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialSearch);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 340,
          height: 44,
          child: TextField(
            controller: _controller,
            onChanged: (val) {
              setState(() {});
              widget.onSearchChanged(val);
            },
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Search blogs by title, desc, or tag...',
              hintStyle: TextStyle(
                color: theme.hintColor.withValues(alpha: 0.5),
                fontSize: 13,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: theme.hintColor.withValues(alpha: 0.5),
                size: 20,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                        widget.onSearchChanged('');
                      },
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      color: theme.hintColor,
                      splashRadius: 16,
                    )
                  : null,
              filled: true,
              fillColor: theme.cardColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.15),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.15),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.primaryColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        if (widget.availableTechnologies.isNotEmpty) ...[
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: widget.selectedTechnology == null,
                  onSelected: (_) => widget.onTechnologySelected(null),
                  selectedColor: theme.primaryColor.withValues(alpha: 0.2),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: widget.selectedTechnology == null
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: widget.selectedTechnology == null
                        ? theme.primaryColor
                        : theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(width: 8),
                ...widget.availableTechnologies.map((tech) {
                  final isSelected = widget.selectedTechnology == tech;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(tech),
                      selected: isSelected,
                      onSelected: (selected) {
                        widget.onTechnologySelected(selected ? tech : null);
                      },
                      selectedColor: theme.primaryColor.withValues(alpha: 0.2),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? theme.primaryColor : theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
