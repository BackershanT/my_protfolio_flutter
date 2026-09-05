import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_protfolio/features/admin/services/project_ai_suggester.dart';

/// Card that displays the selected AI suggestion description + feature chips.
class AiSuggestDescriptionCard extends StatelessWidget {
  final ProjectSuggestion suggestion;
  final bool isDark;

  const AiSuggestDescriptionCard({
    super.key,
    required this.suggestion,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description text + copy button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  suggestion.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: isDark ? const Color(0xDEFFFFFF) : Colors.black87,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy, size: 18),
                tooltip: 'Copy to clipboard',
                color: Colors.grey,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: suggestion.description));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: const Color(0xFF6C63FF).withValues(alpha: 0.15),
          ),
          const SizedBox(height: 10),
          // Feature chips
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: suggestion.keyFeatures
                .map((f) => Chip(
                      label: Text(f),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor:
                          const Color(0xFF6C63FF).withValues(alpha: 0.1),
                      side: BorderSide(
                          color: const Color(0xFF6C63FF).withValues(alpha: 0.2)),
                      labelStyle: const TextStyle(
                          color: Color(0xFF6C63FF), fontSize: 11),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
