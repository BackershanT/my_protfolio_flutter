import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';

class ContactRepository {
  final CollectionReference contacts = FirebaseFirestore.instance.collection(
    'contacts',
  );

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    if (kIsWeb) {
      // For web, we'll still use Firebase for now to avoid WebAssembly issues
      // EmailJS integration would require conditional imports which are complex
      return _sendFirebase(name, email, message);
    } else {
      // Use Firebase for mobile/desktop
      return _sendFirebase(name, email, message);
    }
  }

  Future<void> _sendFirebase(String name, String email, String message) async {
    try {
      // Add a timeout to prevent hanging
      await Future.any([
        contacts.add({
          'name': name,
          'email': email,
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
        }),
        Future.delayed(const Duration(seconds: 10), () {
          throw TimeoutException('Firebase request timed out');
        }),
      ]);
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.code} - ${e.message}');
      if (e.code == 'permission-denied') {
        throw Exception(
          'Firebase permission denied. Please check your Firestore database rules.',
        );
      } else if (e.code == 'unavailable') {
        throw Exception(
          'Firebase service unavailable. Please check your internet connection.',
        );
      } else if (e.code == 'unauthenticated') {
        throw Exception(
          'Firebase authentication required. Please check your Firebase configuration.',
        );
      } else {
        throw Exception('Failed to send message: ${e.message}');
      }
    } on TimeoutException catch (e) {
      print('Timeout error: $e');
      throw Exception(
        'Request timed out. This usually means the Firebase configuration is incorrect or the Firestore database rules don\'t allow writes. Please verify your Firebase setup and database rules.',
      );
    } catch (e) {
      print('Unknown error: $e');
      throw Exception(
        'Failed to send message. Please verify your Firebase configuration and internet connection. Error details: ${e.toString()}',
      );
    }
  }
}
