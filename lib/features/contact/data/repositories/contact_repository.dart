import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'dart:async';

class ContactRepository {
  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await Supabase.instance.client.from('contacts').insert({
        'name': name,
        'email': email,
        'message': message,
      });
    } on PostgrestException catch (e) {
      debugPrint('Supabase error: ${e.code} - ${e.message}');
      throw Exception('Failed to send message: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error: $e');
      throw Exception('Failed to send message. Please verify your internet connection. Error details: ${e.toString()}');
    }
  }
}
