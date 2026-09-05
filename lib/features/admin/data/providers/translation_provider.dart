import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/translation_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/translation_repository.dart';

class TranslationProvider extends ChangeNotifier {
  final TranslationRepository _repository = TranslationRepository();

  List<TranslationModel> _translations = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedCategory = 'all';

  List<TranslationModel> get translations => _translations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  /// Distinct list of categories present in the data
  List<String> get categories {
    final Set<String> cats = {'all'};
    for (final t in _translations) {
      if (t.category.isNotEmpty) {
        cats.add(t.category);
      }
    }
    return cats.toList();
  }

  /// Filtered translations based on category selection and search query
  List<TranslationModel> get filteredTranslations {
    return _translations.where((item) {
      final matchesCategory = _selectedCategory == 'all' ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();

      final query = _searchQuery.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          item.key.toLowerCase().contains(query) ||
          item.en.toLowerCase().contains(query) ||
          item.ar.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> loadTranslations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _translations = await _repository.fetchAll();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateTranslation(TranslationModel item) async {
    try {
      final updated = await _repository.update(item);
      final index = _translations.indexWhere((t) => t.key == item.key);
      if (index != -1) {
        _translations[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> addTranslation(TranslationModel item) async {
    try {
      final created = await _repository.create(item);
      _translations.add(created);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTranslation(String key) async {
    try {
      await _repository.delete(key);
      _translations.removeWhere((t) => t.key == key);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
}
