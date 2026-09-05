import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_protfolio/features/admin/data/models/translation_model.dart';

class TranslationRepository {
  SupabaseClient? get _client {
    try {
      return Supabase.instance.client;
    } catch (e) {
      debugPrint('Supabase client not initialized: $e');
      return null;
    }
  }

  /// Fetch all translations ordered by category, then key
  Future<List<TranslationModel>> fetchAll() async {
    try {
      final client = _client;
      if (client == null) return [];

      final response = await client
          .from('app_translations')
          .select()
          .order('category', ascending: true)
          .order('key', ascending: true);

      final List<dynamic> data = response as List<dynamic>;
      return data
          .map((item) => TranslationModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('TranslationRepository fetchAll error: ${e.message}');
      throw Exception('Failed to fetch translations: ${e.message}');
    } catch (e) {
      debugPrint('TranslationRepository unexpected error: $e');
      throw Exception('Unexpected error fetching translations');
    }
  }

  /// Update translation entry
  Future<TranslationModel> update(TranslationModel item) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final response = await client
          .from('app_translations')
          .update({
            'en': item.en,
            'ar': item.ar,
            'category': item.category,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('key', item.key)
          .select()
          .single();

      return TranslationModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('TranslationRepository update error: ${e.message}');
      throw Exception('Failed to update translation: ${e.message}');
    }
  }

  /// Create or insert new translation entry
  Future<TranslationModel> create(TranslationModel item) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final response = await client
          .from('app_translations')
          .insert(item.toJson())
          .select()
          .single();

      return TranslationModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('TranslationRepository create error: ${e.message}');
      throw Exception('Failed to create translation: ${e.message}');
    }
  }

  /// Delete translation entry
  Future<void> delete(String key) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      await client
          .from('app_translations')
          .delete()
          .eq('key', key);
    } on PostgrestException catch (e) {
      debugPrint('TranslationRepository delete error: ${e.message}');
      throw Exception('Failed to delete translation: ${e.message}');
    }
  }
}
