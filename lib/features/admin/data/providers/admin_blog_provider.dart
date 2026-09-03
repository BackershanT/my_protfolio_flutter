import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/admin_blog_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/admin_blog_repository.dart';

class AdminBlogProvider extends ChangeNotifier {
  final AdminBlogRepository _repository = AdminBlogRepository();

  List<AdminBlogModel> _blogs = [];
  List<AdminBlogModel> _filteredBlogs = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String? _selectedTechnology;

  // Getters
  List<AdminBlogModel> get blogs {
    if (_searchQuery.isEmpty && _selectedTechnology == null) {
      return _blogs;
    }
    return _filteredBlogs;
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String? get selectedTechnology => _selectedTechnology;

  // Stats
  int get totalCount => _blogs.length;

  List<String> get allTechnologies {
    final techSet = <String>{};
    for (final blog in _blogs) {
      techSet.addAll(blog.technologies);
    }
    final list = techSet.toList()..sort();
    return list;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Loads all blogs from Supabase.
  Future<void> loadBlogs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _blogs = await _repository.fetchAll();
      _applyFilter();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new blog post.
  Future<bool> addBlog(AdminBlogModel blog) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final created = await _repository.create(blog);
      _blogs.insert(0, created);
      _applyFilter();
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

  /// Updates an existing blog post by original title.
  Future<bool> updateBlog(String originalTitle, AdminBlogModel blog) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updated = await _repository.update(originalTitle, blog);
      final index = _blogs.indexWhere((b) => b.title == originalTitle);
      if (index != -1) {
        _blogs[index] = updated;
      }
      _applyFilter();
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

  /// Deletes a blog post by title.
  Future<bool> deleteBlog(String title) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.delete(title);
      _blogs.removeWhere((b) => b.title == title);
      _applyFilter();
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

  /// Sets search query and re-filters.
  void setSearchQuery(String query) {
    _searchQuery = query.trim().toLowerCase();
    _applyFilter();
    notifyListeners();
  }

  /// Sets selected technology tag filter.
  void setSelectedTechnology(String? tech) {
    _selectedTechnology = tech;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    _filteredBlogs = _blogs.where((b) {
      final matchesSearch = _searchQuery.isEmpty ||
          b.title.toLowerCase().contains(_searchQuery) ||
          b.description.toLowerCase().contains(_searchQuery) ||
          b.technologies.any((t) => t.toLowerCase().contains(_searchQuery));

      final matchesTech = _selectedTechnology == null ||
          b.technologies.contains(_selectedTechnology);

      return matchesSearch && matchesTech;
    }).toList();
  }
}
