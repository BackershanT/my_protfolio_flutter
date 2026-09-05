import 'package:flutter/material.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';

class TechImageHelper {
  static String resolveImagePath(String techName, String? defaultAssetPath, List<SkillModel> skills) {
    final nameLower = techName.trim().toLowerCase();
    for (final skill in skills) {
      final skillNameLower = skill.name.trim().toLowerCase();
      if (skillNameLower == nameLower ||
          nameLower.contains(skillNameLower) ||
          skillNameLower.contains(nameLower)) {
        if (skill.image.isNotEmpty) {
          return skill.image;
        }
      }
    }
    return defaultAssetPath ?? '';
  }

  static Widget buildDynamicImage(
    String pathOrUrl, {
    BoxFit fit = BoxFit.contain,
    required Widget Function(BuildContext, Object, StackTrace?) errorBuilder,
  }) {
    if (pathOrUrl.isEmpty) {
      return Builder(builder: (context) => errorBuilder(context, Exception('Empty path'), null));
    }
    if (pathOrUrl.startsWith('http://') || pathOrUrl.startsWith('https://')) {
      return Image.network(
        pathOrUrl,
        fit: fit,
        errorBuilder: errorBuilder,
      );
    }
    return Image.asset(
      pathOrUrl,
      fit: fit,
      errorBuilder: errorBuilder,
    );
  }
}
