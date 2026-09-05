import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_protfolio/features/admin/data/models/contact_message_model.dart';

class AdminContactRepository {
  final SupabaseClient _client = Supabase.instance.client;

  /// Fetch all contact messages ordered by creation date (newest first).
  Future<List<ContactMessageModel>> fetchAllMessages() async {
    try {
      final response = await _client
          .from('contacts')
          .select()
          .order('created_at', ascending: false);

      final List<dynamic> data = response as List<dynamic>;
      return data
          .map((item) => ContactMessageModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      debugPrint('AdminContactRepository fetchAllMessages error: ${e.message}');
      throw Exception('Failed to fetch contact messages: ${e.message}');
    } catch (e) {
      debugPrint('AdminContactRepository unexpected error: $e');
      throw Exception('Unexpected error fetching contact messages');
    }
  }

  /// Toggle or update the is_read status of a message.
  Future<void> markAsRead(String id, bool isRead) async {
    try {
      await _client
          .from('contacts')
          .update({'is_read': isRead})
          .eq('id', id);
    } on PostgrestException catch (e) {
      debugPrint('AdminContactRepository markAsRead error: ${e.message}');
      throw Exception('Failed to update message status: ${e.message}');
    }
  }

  /// Delete a contact message entry.
  Future<void> deleteMessage(String id) async {
    try {
      await _client
          .from('contacts')
          .delete()
          .eq('id', id);
    } on PostgrestException catch (e) {
      debugPrint('AdminContactRepository deleteMessage error: ${e.message}');
      throw Exception('Failed to delete message: ${e.message}');
    }
  }
}
