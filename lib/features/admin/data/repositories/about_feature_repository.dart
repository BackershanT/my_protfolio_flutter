import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_protfolio/features/admin/data/models/about_feature_model.dart';

class AboutFeatureRepository {
  final SupabaseClient _client = Supabase.instance.client;

  /// Fetch all feature cards ordered by sort_order
  Future<List<AboutFeatureModel>> fetchAll() async {
    try {
      final response = await _client
          .from('about_features')
          .select()
          .order('sort_order', ascending: true);

      final List<dynamic> data = response as List<dynamic>;
      return data
          .map((item) => AboutFeatureModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('AboutFeatureRepository fetchAll error: ${e.message}');
      throw Exception('Failed to fetch about features: ${e.message}');
    } catch (e) {
      debugPrint('AboutFeatureRepository unexpected error: $e');
      throw Exception('Unexpected error fetching about features');
    }
  }

  /// Create new feature card
  Future<AboutFeatureModel> create(AboutFeatureModel feature) async {
    try {
      final response = await _client
          .from('about_features')
          .insert(feature.toJson())
          .select()
          .single();

      return AboutFeatureModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('AboutFeatureRepository create error: ${e.message}');
      throw Exception('Failed to create feature card: ${e.message}');
    }
  }

  /// Update existing feature card
  Future<AboutFeatureModel> update(String id, AboutFeatureModel feature) async {
    try {
      final response = await _client
          .from('about_features')
          .update(feature.toJson())
          .eq('id', id)
          .select()
          .single();

      return AboutFeatureModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('AboutFeatureRepository update error: ${e.message}');
      throw Exception('Failed to update feature card: ${e.message}');
    }
  }

  /// Delete feature card
  Future<void> delete(String id) async {
    try {
      await _client
          .from('about_features')
          .delete()
          .eq('id', id);
    } on PostgrestException catch (e) {
      debugPrint('AboutFeatureRepository delete error: ${e.message}');
      throw Exception('Failed to delete feature card: ${e.message}');
    }
  }
}
