import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/services/project_ai_suggester.dart';

/// Horizontal tab row for switching between AI suggestion variants.
class AiSuggestVariantTabs extends StatelessWidget {
  final List<ProjectSuggestion> suggestions;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool isDark;

  const AiSuggestVariantTabs({
    super.key,
    required this.suggestions,
    required this.selectedIndex,
    required this.onSelected,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: List.generate(suggestions.length, (i) {
        final isSelected = i == selectedIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelected(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: i < suggestions.length - 1 ? 8 : 0),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFFB06AB3)],
                      )
                    : null,
                color: isSelected
                    ? null
                    : (isDark ? const Color(0xFF1A1A2E) : Colors.grey.shade100),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : (isDark ? Colors.white12 : Colors.grey.shade300),
                ),
              ),
              child: Text(
                suggestions[i].label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : theme.hintColor,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
