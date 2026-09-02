import 'package:flutter/material.dart';

/// Styled search bar for filtering testimonials.
///
/// Features a search icon, clear button, and themed styling
/// matching the admin design system.
class TestimonialSearchBar extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String initialValue;

  const TestimonialSearchBar({
    super.key,
    required this.onChanged,
    this.initialValue = '',
  });

  @override
  State<TestimonialSearchBar> createState() => _TestimonialSearchBarState();
}

class _TestimonialSearchBarState extends State<TestimonialSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 300,
      height: 44,
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Search testimonials...',
          hintStyle: TextStyle(
            color: theme.hintColor.withOpacity(0.5),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: theme.hintColor.withOpacity(0.5),
            size: 20,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _controller.clear();
                    widget.onChanged('');
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: theme.hintColor,
                    size: 18,
                  ),
                  splashRadius: 18,
                )
              : null,
          filled: true,
          fillColor: theme.cardColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
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
        ),
      ),
    );
  }
}
