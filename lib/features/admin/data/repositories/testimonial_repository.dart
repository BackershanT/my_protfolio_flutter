import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:my_protfolio/features/admin/data/models/testimonial_model.dart';
class TestimonialRepository {
  SupabaseClient? get _client {
    try {
      return Supabase.instance.client;
    } catch (e) {
      debugPrint('Supabase client not initialized: $e');
      return null;
    }
  }
  static const String _table = 'testimonials';

  /// Fetches all testimonials ordered by created_at descending.
  Future<List<TestimonialModel>> fetchAll() async {
    try {
      final client = _client;
      if (client == null) return [];

      final response = await client
          .from(_table)
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => TestimonialModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('Supabase fetchAll error: ${e.code} - ${e.message}');
      return [];
    } catch (e) {
      debugPrint('Unknown fetchAll error: $e');
      return [];
    }
  }

  /// Creates a new testimonial and returns the inserted record.
  Future<TestimonialModel> create(TestimonialModel testimonial) async {
    try {
      final response = await _client
          .from(_table)
          .insert(testimonial.toJson())
          .select()
          .single();

      return TestimonialModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase create error: ${e.code} - ${e.message}');
      throw Exception('Failed to create testimonial: ${e.message}');
    } catch (e) {
      debugPrint('Unknown create error: $e');
      throw Exception('Failed to create testimonial: ${e.toString()}');
    }
  }

  /// Updates an existing testimonial by ID and returns the updated record.
  Future<TestimonialModel> update(TestimonialModel testimonial) async {
    try {
      if (testimonial.id == null) {
        throw Exception('Cannot update testimonial without an ID');
      }

      final response = await _client
          .from(_table)
          .update(testimonial.toJson())
          .eq('id', testimonial.id!)
          .select()
          .single();

      return TestimonialModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase update error: ${e.code} - ${e.message}');
      throw Exception('Failed to update testimonial: ${e.message}');
    } catch (e) {
      debugPrint('Unknown update error: $e');
      throw Exception('Failed to update testimonial: ${e.toString()}');
    }
  }

  /// Deletes a testimonial by ID.
  Future<void> delete(int id) async {
    try {
      await _client.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      debugPrint('Supabase delete error: ${e.code} - ${e.message}');
      throw Exception('Failed to delete testimonial: ${e.message}');
    } catch (e) {
      debugPrint('Unknown delete error: $e');
      throw Exception('Failed to delete testimonial: ${e.toString()}');
    }
  }

  /// Uploads an avatar image to Supabase Storage and returns the public URL.
  Future<String> uploadAvatar(Uint8List fileBytes, String fileName) async {
    try {
      final fileExtension = fileName.split('.').last;
      final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${fileName.hashCode}.$fileExtension';
      final path = 'avatars/$uniqueFileName';

      await _client.storage.from('testimonials').uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      final publicUrl = _client.storage.from('testimonials').getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      debugPrint('Supabase uploadAvatar error: $e');
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }
}
