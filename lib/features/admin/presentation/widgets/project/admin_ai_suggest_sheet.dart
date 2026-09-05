import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/services/project_ai_suggester.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/ai_suggest_skeleton.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/ai_suggest_variant_tabs.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/ai_suggest_description_card.dart';
import 'package:my_protfolio/features/admin/presentation/widgets/project/ai_suggest_ideas_section.dart';

/// Bottom sheet that shows AI-generated project description suggestions.
class AdminAiSuggestSheet extends StatefulWidget {
  final String projectName;
  final List<String> technologies;
  final List<String> types;
  final String? companyName;
  final void Function(String description) onAccept;

  const AdminAiSuggestSheet({
    super.key,
    required this.projectName,
    required this.technologies,
    required this.types,
    this.companyName,
    required this.onAccept,
  });

  static Future<void> show(
    BuildContext context, {
    required String projectName,
    required List<String> technologies,
    required List<String> types,
    String? companyName,
    required void Function(String) onAccept,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AdminAiSuggestSheet(
        projectName: projectName,
        technologies: technologies,
        types: types,
        companyName: companyName,
        onAccept: onAccept,
      ),
    );
  }

  @override
  State<AdminAiSuggestSheet> createState() => _AdminAiSuggestSheetState();
}

class _AdminAiSuggestSheetState extends State<AdminAiSuggestSheet>
    with TickerProviderStateMixin {
  late final AnimationController _shimmerController;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnim;

  List<ProjectSuggestion> _suggestions = [];
  bool _isGenerating = true;
  int _selectedIndex = 0;
  bool _showIdeas = false;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _generate();
  }

  Future<void> _generate() async {
    setState(() => _isGenerating = true);
    _fadeController.reset();
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _suggestions = ProjectAISuggester.suggest(
        projectName: widget.projectName,
        technologies: widget.technologies,
        types: widget.types,
        companyName: widget.companyName,
      );
      _isGenerating = false;
      _selectedIndex = 0;
    });
    _fadeController.forward();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenH = MediaQuery.of(context).size.height;

    return Container(
      height: screenH * 0.88,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F0F17) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(
          color: const Color(0xFF6C63FF).withValues(alpha: 0.25),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHandle(),
          _SheetHeader(projectName: widget.projectName, isDark: isDark),
          const Divider(height: 1),
          Expanded(
            child: _isGenerating
                ? AiSuggestSkeleton(shimmer: _shimmerController, isDark: isDark)
                : _buildBody(theme, isDark),
          ),
          if (!_isGenerating) _SheetFooter(
            onRegenerate: _generate,
            onAccept: _suggestions.isEmpty
                ? null
                : () {
                    widget.onAccept(_suggestions[_selectedIndex].description);
                    Navigator.of(context).pop();
                  },
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ThemeData theme, bool isDark) {
    if (_suggestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info_outline, size: 40, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              'Please enter a project name first',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    final selected = _suggestions[_selectedIndex];
    return FadeTransition(
      opacity: _fadeAnim,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AiSuggestVariantTabs(
              suggestions: _suggestions,
              selectedIndex: _selectedIndex,
              isDark: isDark,
              onSelected: (i) => setState(() => _selectedIndex = i),
            ),
            const SizedBox(height: 16),
            AiSuggestDescriptionCard(suggestion: selected, isDark: isDark),
            const SizedBox(height: 20),
            AiSuggestIdeasSection(
              suggestion: selected,
              isDark: isDark,
              isExpanded: _showIdeas,
              onToggle: () => setState(() => _showIdeas = !_showIdeas),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

// ── Private layout sub-widgets ──────────────────────────────────────────────

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 4),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  final String projectName;
  final bool isDark;
  const _SheetHeader({required this.projectName, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFFB06AB3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Description Suggestions',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  'Based on "$projectName"',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF6C63FF),
                    fontWeight: FontWeight.w500,
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
    );
  }
}

class _SheetFooter extends StatelessWidget {
  final VoidCallback onRegenerate;
  final VoidCallback? onAccept;
  const _SheetFooter({required this.onRegenerate, this.onAccept});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: theme.dividerColor.withValues(alpha: 0.15))),
        color: theme.scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onRegenerate,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Regenerate'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFFB06AB3)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed: onAccept,
                icon: const Icon(Icons.check, size: 18, color: Colors.white),
                label: const Text(
                  'Use This Description',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
