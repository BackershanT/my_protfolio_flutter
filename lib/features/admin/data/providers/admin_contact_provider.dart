import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/contact_message_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/admin_contact_repository.dart';

enum MessageFilter { all, unread, read }

class AdminContactProvider extends ChangeNotifier {
  final AdminContactRepository _repository = AdminContactRepository();

  List<ContactMessageModel> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  MessageFilter _selectedFilter = MessageFilter.all;

  List<ContactMessageModel> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  MessageFilter get selectedFilter => _selectedFilter;

  int get totalCount => _messages.length;
  int get unreadCount => _messages.where((m) => !m.isRead).length;
  int get readCount => _messages.where((m) => m.isRead).length;

  /// Filtered messages based on search query and read/unread tab filter
  List<ContactMessageModel> get filteredMessages {
    return _messages.where((msg) {
      // Filter by status
      if (_selectedFilter == MessageFilter.unread && msg.isRead) return false;
      if (_selectedFilter == MessageFilter.read && !msg.isRead) return false;

      // Filter by search query
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchName = msg.name.toLowerCase().contains(q);
        final matchEmail = msg.email.toLowerCase().contains(q);
        final matchMessage = msg.message.toLowerCase().contains(q);
        return matchName || matchEmail || matchMessage;
      }

      return true;
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(MessageFilter filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  Future<void> loadMessages() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _messages = await _repository.fetchAllMessages();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> markAsRead(String id, bool isRead) async {
    try {
      await _repository.markAsRead(id, isRead);
      final index = _messages.indexWhere((m) => m.id == id);
      if (index != -1) {
        _messages[index] = _messages[index].copyWith(isRead: isRead);
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteMessage(String id) async {
    try {
      await _repository.deleteMessage(id);
      _messages.removeWhere((m) => m.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
}
