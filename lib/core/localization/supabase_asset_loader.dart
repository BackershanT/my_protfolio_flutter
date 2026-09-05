import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Custom AssetLoader for EasyLocalization that fetches translations
/// dynamically from Supabase `app_translations` with an automatic fallback
/// to bundled local JSON files.
class SupabaseAssetLoader extends AssetLoader {
  const SupabaseAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    // 1. Load local fallback bundled JSON first
    Map<String, dynamic> translations = {};
    try {
      final fallbackData = await const RootBundleAssetLoader().load(path, locale);
      if (fallbackData != null) {
        translations.addAll(fallbackData);
      }
    } catch (e) {
      log('SupabaseAssetLoader: Local fallback load warning: $e');
    }

    // 2. Fetch remote translations from Supabase
    try {
      final client = Supabase.instance.client;
      final langCode = locale.languageCode.toLowerCase();
      final targetColumn = langCode == 'ar' ? 'ar' : 'en';

      final response = await client
          .from('app_translations')
          .select('key, $targetColumn')
          .timeout(const Duration(seconds: 5));

      final rows = response as List<dynamic>;
      for (final row in rows) {
        final key = row['key'] as String?;
        final val = row[targetColumn] as String?;
        if (key != null && val != null && val.isNotEmpty) {
          translations[key] = val;
        }
      }
      log('SupabaseAssetLoader: Successfully loaded ${rows.length} translations for locale [$langCode]');
    } catch (e) {
      log('SupabaseAssetLoader: Network/Supabase fetch failed, using fallback assets: $e');
    }

    return translations;
  }
}
