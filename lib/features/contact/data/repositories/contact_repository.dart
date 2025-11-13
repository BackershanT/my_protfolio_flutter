import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository {
  final CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await contacts.add({
        'name': name,
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }
}