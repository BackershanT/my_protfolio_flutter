import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';

class SkillRepository {
  SupabaseClient? get _client {
    try {
      return Supabase.instance.client;
    } catch (e) {
      debugPrint('Supabase client not initialized: $e');
      return null;
    }
  }
  static const String _table = 'skills';

  /// Fetches all skills ordered by id ascending.
  Future<List<SkillModel>> fetchAll() async {
    try {
      final client = _client;
      if (client == null) return [];

      final response = await client
          .from(_table)
          .select()
          .order('id', ascending: true);

      return (response as List)
          .map((json) => SkillModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('Supabase fetchAll error: ${e.code} - ${e.message}');
      return [];
    } catch (e) {
      debugPrint('Unknown fetchAll error: $e');
      return [];
    }
  }

  /// Fetches only active skills from Supabase.
  Future<List<SkillModel>> fetchActiveOnly() async {
    try {
      final client = _client;
      if (client == null) return [];

      final response = await client
          .from(_table)
          .select()
          .eq('is_active', true)
          .order('id', ascending: true);

      return (response as List)
          .map((json) => SkillModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('Supabase fetchActiveOnly error: ${e.code} - ${e.message}');
      throw Exception('Failed to fetch active skills: ${e.message}');
    } catch (e) {
      debugPrint('Unknown fetchActiveOnly error: $e');
      throw Exception('Failed to fetch active skills: ${e.toString()}');
    }
  }

  /// Creates a new skill and returns the inserted record.
  Future<SkillModel> create(SkillModel skill) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final response = await client
          .from(_table)
          .insert(skill.toJson())
          .select()
          .single();

      return SkillModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase create error: ${e.code} - ${e.message}');
      throw Exception('Failed to create skill: ${e.message}');
    } catch (e) {
      debugPrint('Unknown create error: $e');
      throw Exception('Failed to create skill: ${e.toString()}');
    }
  }

  /// Updates an existing skill by ID and returns the updated record.
  Future<SkillModel> update(SkillModel skill) async {
    try {
      if (skill.id == null) {
        throw Exception('Cannot update skill without an ID');
      }

      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final response = await client
          .from(_table)
          .update(skill.toJson())
          .eq('id', skill.id!)
          .select()
          .single();

      return SkillModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase update error: ${e.code} - ${e.message}');
      throw Exception('Failed to update skill: ${e.message}');
    } catch (e) {
      debugPrint('Unknown update error: $e');
      throw Exception('Failed to update skill: ${e.toString()}');
    }
  }

  /// Toggles the active status of a skill by ID.
  Future<SkillModel> toggleActive(int id, bool isActive) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final response = await client
          .from(_table)
          .update({
            'is_active': isActive,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id)
          .select()
          .single();

      return SkillModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Supabase toggleActive error: ${e.code} - ${e.message}');
      throw Exception('Failed to update skill status: ${e.message}');
    } catch (e) {
      debugPrint('Unknown toggleActive error: $e');
      throw Exception('Failed to update skill status: ${e.toString()}');
    }
  }

  /// Deletes a skill by ID.
  Future<void> delete(int id) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      await client.from(_table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      debugPrint('Supabase delete error: ${e.code} - ${e.message}');
      throw Exception('Failed to delete skill: ${e.message}');
    } catch (e) {
      debugPrint('Unknown delete error: $e');
      throw Exception('Failed to delete skill: ${e.toString()}');
    }
  }

  /// Uploads an icon image to Supabase Storage and returns the public URL.
  Future<String> uploadIcon(Uint8List fileBytes, String fileName) async {
    try {
      final client = _client;
      if (client == null) throw Exception('Database client not initialized');

      final fileExtension = fileName.split('.').last;
      final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${fileName.hashCode}.$fileExtension';
      final path = 'icons/$uniqueFileName';

      await client.storage.from('skills').uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      final publicUrl = client.storage.from('skills').getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      debugPrint('Supabase uploadIcon error: $e');
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }
}
