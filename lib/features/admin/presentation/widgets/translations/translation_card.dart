import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/translation_model.dart';
import 'package:my_protfolio/features/admin/data/providers/translation_provider.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/translations/translation_edit_dialog.dart';

class TranslationCard extends StatelessWidget {
  final TranslationModel item;
  final TranslationProvider provider;

  const TranslationCard({
    super.key,
    required this.item,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Card(
      elevation: 0.5,
      color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Key name, Category Badge, Edit Button
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.key,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () => TranslationEditDialog.show(
                    context,
                    item: item,
                    provider: provider,
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 14),
                  label: const Text('Edit', style: TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // Content Preview: English & Arabic
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildLanguageSnippet(
                      flag: '🇬🇧',
                      lang: 'EN',
                      text: item.en,
                      textDirection: TextDirection.ltr,
                      theme: theme,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildLanguageSnippet(
                      flag: '🇸🇦',
                      lang: 'AR',
                      text: item.ar,
                      textDirection: TextDirection.rtl,
                      theme: theme,
                      isDark: isDark,
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildLanguageSnippet(
                    flag: '🇬🇧',
                    lang: 'EN',
                    text: item.en,
                    textDirection: TextDirection.ltr,
                    theme: theme,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 10),
                  _buildLanguageSnippet(
                    flag: '🇸🇦',
                    lang: 'AR',
                    text: item.ar,
                    textDirection: TextDirection.rtl,
                    theme: theme,
                    isDark: isDark,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSnippet({
    required String flag,
    required String lang,
    required String text,
    required TextDirection textDirection,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? Colors.black26 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(
                lang,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white60 : Colors.black45,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            text.isEmpty ? '(Empty)' : text,
            textDirection: textDirection,
            style: TextStyle(
              fontSize: 13,
              fontStyle: text.isEmpty ? FontStyle.italic : FontStyle.normal,
              color: text.isEmpty
                  ? (isDark ? Colors.white38 : Colors.black38)
                  : (isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
