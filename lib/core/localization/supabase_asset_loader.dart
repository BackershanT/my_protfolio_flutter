import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Custom AssetLoader for EasyLocalization that fetches translations
/// dynamically from Supabase `app_translations` with an automatic fallback
/// to bundled local JSON files.
class SupabaseAssetLoader extends AssetLoader {
  const SupabaseAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    Map<String, dynamic> translations = {};
    final langCode = locale.languageCode.toLowerCase();

    // 1. Load local fallback JSON file first (assets/translations/en.json or ar.json)
    try {
      final jsonString = await rootBundle.loadString('$path/$langCode.json');
      final Map<String, dynamic> localData = json.decode(jsonString);
      translations.addAll(localData);
      log('SupabaseAssetLoader: Loaded ${localData.length} local fallback translations for [$langCode]');
    } catch (e) {
      log('SupabaseAssetLoader: Failed to load local asset fallback: $e');
    }

    // 2. Fetch translations from Supabase app_translations table in background without blocking app startup
    _fetchRemoteTranslationsAsync(langCode, translations);

    return translations;
  }

  void _fetchRemoteTranslationsAsync(
      String langCode, Map<String, dynamic> targetMap) {
    try {
      final client = Supabase.instance.client;
      final targetColumn = langCode == 'ar' ? 'ar' : 'en';

      client
          .from('app_translations')
          .select('key, $targetColumn')
          .timeout(const Duration(seconds: 4))
          .then((response) {
        final rows = response as List<dynamic>;
        for (final row in rows) {
          final key = row['key'] as String?;
          final val = row[targetColumn] as String?;
          if (key != null && val != null && val.isNotEmpty) {
            targetMap[key] = val;
          }
        }
        log('SupabaseAssetLoader: Successfully merged ${rows.length} remote translations for [$langCode]');
      }).catchError((e) {
        log('SupabaseAssetLoader: Background fetch note (using local fallbacks): $e');
      });
    } catch (e) {
      log('SupabaseAssetLoader: Background init note: $e');
    }
  }
}
