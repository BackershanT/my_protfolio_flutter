import 'package:flutter/material.dart';

/// Styled search bar and status filter chips for skills in the admin panel.
class AdminSkillSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onFilterChanged;
  final String initialSearch;
  final String currentFilter;
  final int totalCount;
  final int activeCount;
  final int inactiveCount;

  const AdminSkillSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterChanged,
    this.initialSearch = '',
    this.currentFilter = 'all',
    this.totalCount = 0,
    this.activeCount = 0,
    this.inactiveCount = 0,
  });

  @override
  State<AdminSkillSearchBar> createState() => _AdminSkillSearchBarState();
}

class _AdminSkillSearchBarState extends State<AdminSkillSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialSearch);
  }

  @override
  void didUpdateWidget(covariant AdminSkillSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSearch != _controller.text) {
      _controller.text = widget.initialSearch;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      children: [
        // Search Input
        SizedBox(
          width: 320,
          height: 44,
          child: TextField(
            controller: _controller,
            onChanged: (val) {
              setState(() {});
              widget.onSearchChanged(val);
            },
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Search skills by name...',
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
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.1),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.1),
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

        // Filter chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFilterChip(
              theme: theme,
              label: 'All (${widget.totalCount})',
              filterValue: 'all',
              isSelected: widget.currentFilter == 'all',
              onSelected: () => widget.onFilterChanged('all'),
            ),
            _buildFilterChip(
              theme: theme,
              label: 'Active (${widget.activeCount})',
              filterValue: 'active',
              isSelected: widget.currentFilter == 'active',
              onSelected: () => widget.onFilterChanged('active'),
              color: Colors.green,
            ),
            _buildFilterChip(
              theme: theme,
              label: 'Inactive (${widget.inactiveCount})',
              filterValue: 'inactive',
              isSelected: widget.currentFilter == 'inactive',
              onSelected: () => widget.onFilterChanged('inactive'),
              color: Colors.amber,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required ThemeData theme,
    required String label,
    required String filterValue,
    required bool isSelected,
    required VoidCallback onSelected,
    Color? color,
  }) {
    return FilterChip(
      selected: isSelected,
      label: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.white : null,
          fontSize: 12,
        ),
      ),
      selectedColor: color ?? theme.colorScheme.primary,
      checkmarkColor: Colors.white,
      onSelected: (_) => onSelected(),
    );
  }
}

