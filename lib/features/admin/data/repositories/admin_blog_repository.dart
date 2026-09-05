import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:my_protfolio/features/admin/data/models/admin_blog_model.dart';

class AdminBlogRepository {
  SupabaseClient? get _client {
    try {
      return Supabase.instance.client;
    } catch (e) {
      debugPrint('Supabase client not initialized: $e');
      return null;
    }
  }
  static const String _table = 'blogs';
  static const String _bucket = 'blog';

  /// Fetches all blogs ordered by date descending.
  Future<List<AdminBlogModel>> fetchAll() async {
    try {
      final client = _client;
      if (client == null) return [];

      final response = await client
          .from(_table)
          .select()
          .order('date', ascending: false);

      return (response as List)
          .map((json) => AdminBlogModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('Supabase fetchAll blogs error: ${e.code} - ${e.message}');
      return [];
    } catch (e) {
      debugPrint('Unknown fetchAll blogs error: $e');
      return [];
    }
  }

  /// Creates a new blog post.
  Future<AdminBlogModel> create(AdminBlogModel blog) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final response = await client
          .from(_table)
          .insert(blog.toJson())
          .select()
          .single();

      return AdminBlogModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase create blog error: ${e.code} - ${e.message}');
      throw Exception('Failed to create blog: ${e.message}');
    } catch (e) {
      debugPrint('Unknown create blog error: $e');
      throw Exception('Failed to create blog: ${e.toString()}');
    }
  }

  /// Updates an existing blog by matching original title.
  Future<AdminBlogModel> update(String originalTitle, AdminBlogModel blog) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final response = await client
          .from(_table)
          .update(blog.toJson())
          .eq('title', originalTitle)
          .select()
          .single();

      return AdminBlogModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase update blog error: ${e.code} - ${e.message}');
      throw Exception('Failed to update blog: ${e.message}');
    } catch (e) {
      debugPrint('Unknown update blog error: $e');
      throw Exception('Failed to update blog: ${e.toString()}');
    }
  }

  /// Deletes a blog by title.
  Future<void> delete(String title) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      await client.from(_table).delete().eq('title', title);
    } on PostgrestException catch (e) {
      debugPrint('Supabase delete blog error: ${e.code} - ${e.message}');
      throw Exception('Failed to delete blog: ${e.message}');
    } catch (e) {
      debugPrint('Unknown delete blog error: $e');
      throw Exception('Failed to delete blog: ${e.toString()}');
    }
  }

  /// Uploads a cover image to the Supabase 'blog' storage bucket.
  Future<String> uploadCoverImage(Uint8List fileBytes, String fileName) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final fileExtension = fileName.split('.').last;
      final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${fileName.hashCode}.$fileExtension';
      final path = 'covers/$uniqueFileName';

      await client.storage.from(_bucket).uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      final publicUrl = client.storage.from(_bucket).getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      debugPrint('Supabase uploadCoverImage error: $e');
      throw Exception('Failed to upload blog cover image: ${e.toString()}');
    }
  }
}
