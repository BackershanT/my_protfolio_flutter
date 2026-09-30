import 'package:flutter/material.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';

class TechImageHelper {
  static String _normalize(String text) {
    return text.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  static String resolveImagePath(String techName, String? defaultAssetPath, List<SkillModel> skills) {
    final normTech = _normalize(techName);
    if (normTech.isEmpty) return defaultAssetPath ?? '';

    // 1. Exact normalized match
    for (final skill in skills) {
      final normSkill = _normalize(skill.name);
      if (normSkill == normTech && skill.image.isNotEmpty) {
        return skill.image;
      }
    }

    // 2. Partial / Substring match
    for (final skill in skills) {
      final normSkill = _normalize(skill.name);
      if (normSkill.isNotEmpty &&
          (normTech.contains(normSkill) || normSkill.contains(normTech))) {
        if (skill.image.isNotEmpty) {
          return skill.image;
        }
      }
    }

    final fallback = defaultAssetPath ?? '';
    if (fallback.startsWith('assets/assets/')) {
      return fallback.replaceFirst('assets/assets/', 'assets/');
    } else if (fallback.startsWith('/assets/')) {
      return fallback.substring(1);
    }

    return fallback;
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
