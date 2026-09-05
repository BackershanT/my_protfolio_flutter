import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:my_protfolio/features/admin/data/models/admin_project_model.dart';

class AdminProjectRepository {
  SupabaseClient get _client => Supabase.instance.client;
  static const String _table = 'projects';
  static const String _coverBucket = 'projects';
  static const String _screenshotsBucket = 'project_screenshots';

  /// Fetches all projects.
  Future<List<AdminProjectModel>> fetchAll() async {
    try {
      final response = await _client
          .from(_table)
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => AdminProjectModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('Supabase fetchAll projects error: ${e.code} - ${e.message}');
      throw Exception('Failed to fetch projects: ${e.message}');
    } catch (e) {
      debugPrint('Unknown fetchAll projects error: $e');
      throw Exception('Failed to fetch projects: ${e.toString()}');
    }
  }

  /// Creates a new project.
  Future<AdminProjectModel> create(AdminProjectModel project) async {
    try {
      final response = await _client
          .from(_table)
          .insert(project.toJson())
          .select()
          .single();

      return AdminProjectModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase create project error: ${e.code} - ${e.message}');
      throw Exception('Failed to create project: ${e.message}');
    } catch (e) {
      debugPrint('Unknown create project error: $e');
      throw Exception('Failed to create project: ${e.toString()}');
    }
  }

  /// Updates an existing project by matching original name.
  Future<AdminProjectModel> update(String originalName, AdminProjectModel project) async {
    try {
      final response = await _client
          .from(_table)
          .update(project.toJson())
          .eq('name', originalName)
          .select()
          .single();

      return AdminProjectModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase update project error: ${e.code} - ${e.message}');
      throw Exception('Failed to update project: ${e.message}');
    } catch (e) {
      debugPrint('Unknown update project error: $e');
      throw Exception('Failed to update project: ${e.toString()}');
    }
  }

  /// Deletes a project by name.
  Future<void> delete(String name) async {
    try {
      await _client.from(_table).delete().eq('name', name);
    } on PostgrestException catch (e) {
      debugPrint('Supabase delete project error: ${e.code} - ${e.message}');
      throw Exception('Failed to delete project: ${e.message}');
    } catch (e) {
      debugPrint('Unknown delete project error: $e');
      throw Exception('Failed to delete project: ${e.toString()}');
    }
  }

  /// Uploads cover image to 'projects' storage bucket.
  Future<String> uploadCoverImage(Uint8List fileBytes, String fileName) async {
    try {
      final fileExtension = fileName.split('.').last;
      final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${fileName.hashCode}.$fileExtension';
      final path = 'covers/$uniqueFileName';

      await _client.storage.from(_coverBucket).uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      return _client.storage.from(_coverBucket).getPublicUrl(path);
    } catch (e) {
      debugPrint('Supabase uploadCoverImage error: $e');
      throw Exception('Failed to upload cover image: ${e.toString()}');
    }
  }

  /// Uploads screenshot to 'project_screenshots' storage bucket.
  Future<String> uploadScreenshot(Uint8List fileBytes, String fileName) async {
    try {
      final fileExtension = fileName.split('.').last;
      final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${fileName.hashCode}.$fileExtension';
      final path = 'screenshots/$uniqueFileName';

      await _client.storage.from(_screenshotsBucket).uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      return _client.storage.from(_screenshotsBucket).getPublicUrl(path);
    } catch (e) {
      debugPrint('Supabase uploadScreenshot error: $e');
      throw Exception('Failed to upload screenshot: ${e.toString()}');
    }
  }
}
