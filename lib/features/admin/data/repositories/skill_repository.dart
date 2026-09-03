import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';

class SkillRepository {
  final _client = Supabase.instance.client;
  static const String _table = 'skills';

  /// Fetches all skills ordered by created_at descending.
  Future<List<SkillModel>> fetchAll() async {
    try {
      final response = await _client
          .from(_table)
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => SkillModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('Supabase fetchAll error: ${e.code} - ${e.message}');
      throw Exception('Failed to fetch skills: ${e.message}');
    } catch (e) {
      debugPrint('Unknown fetchAll error: $e');
      throw Exception('Failed to fetch skills: ${e.toString()}');
    }
  }

  /// Creates a new skill and returns the inserted record.
  Future<SkillModel> create(SkillModel skill) async {
    try {
      final response = await _client
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

      final response = await _client
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

  /// Deletes a skill by ID.
  Future<void> delete(int id) async {
    try {
      await _client.from(_table).delete().eq('id', id);
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
      final fileExtension = fileName.split('.').last;
      final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${fileName.hashCode}.$fileExtension';
      final path = 'icons/$uniqueFileName';

      await _client.storage.from('skills').uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      final publicUrl = _client.storage.from('skills').getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      debugPrint('Supabase uploadIcon error: $e');
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }
}
