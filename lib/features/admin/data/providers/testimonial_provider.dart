import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/testimonial_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/testimonial_repository.dart';

class TestimonialProvider extends ChangeNotifier {
  final TestimonialRepository _repository = TestimonialRepository();

  List<TestimonialModel> _testimonials = [];
  List<TestimonialModel> _filteredTestimonials = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  // Getters
  List<TestimonialModel> get testimonials =>
      _searchQuery.isEmpty ? _testimonials : _filteredTestimonials;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  // Stats
  int get totalCount => _testimonials.length;
  int get featuredCount =>
      _testimonials.where((t) => t.isFeatured).length;
  double get averageRating {
    if (_testimonials.isEmpty) return 0;
    final total = _testimonials.fold<int>(0, (sum, t) => sum + t.rating);
    return total / _testimonials.length;
  }

  /// Loads all testimonials from Supabase.
  Future<void> loadTestimonials() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _testimonials = await _repository.fetchAll();
      _applySearchFilter();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new testimonial.
  Future<bool> addTestimonial(TestimonialModel testimonial) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final created = await _repository.create(testimonial);
      _testimonials.insert(0, created);
      _applySearchFilter();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Updates an existing testimonial.
  Future<bool> updateTestimonial(TestimonialModel testimonial) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updated = await _repository.update(testimonial);
      final index = _testimonials.indexWhere((t) => t.id == updated.id);
      if (index != -1) {
        _testimonials[index] = updated;
      }
      _applySearchFilter();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Deletes a testimonial by ID.
  Future<bool> deleteTestimonial(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.delete(id);
      _testimonials.removeWhere((t) => t.id == id);
      _applySearchFilter();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Updates the search query and filters testimonials.
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applySearchFilter();
    notifyListeners();
  }

  /// Clears any error messages.
  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _applySearchFilter() {
    if (_searchQuery.isEmpty) {
      _filteredTestimonials = _testimonials;
      return;
    }

    final query = _searchQuery.toLowerCase();
    _filteredTestimonials = _testimonials.where((t) {
      return t.name.toLowerCase().contains(query) ||
          t.role.toLowerCase().contains(query) ||
          (t.company?.toLowerCase().contains(query) ?? false) ||
          t.content.toLowerCase().contains(query);
    }).toList();
  }
}
