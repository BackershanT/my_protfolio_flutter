import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/admin_project_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/admin_project_repository.dart';

class AdminProjectProvider extends ChangeNotifier {
  final AdminProjectRepository _repository = AdminProjectRepository();

  List<AdminProjectModel> _projects = [];
  List<AdminProjectModel> _filteredProjects = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String? _selectedTechnology;

  // Getters
  List<AdminProjectModel> get projects {
    if (_searchQuery.isEmpty && _selectedTechnology == null) {
      return _projects;
    }
    return _filteredProjects;
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String? get selectedTechnology => _selectedTechnology;

  // Stats
  int get totalCount => _projects.length;

  int get companiesCount {
    final companies = _projects
        .map((p) => p.companyName.trim())
        .where((c) => c.isNotEmpty)
        .toSet();
    return companies.length;
  }

  List<String> get allTechnologies {
    final techSet = <String>{};
    for (final project in _projects) {
      techSet.addAll(project.technologies);
    }
    final list = techSet.toList()..sort();
    return list;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Loads all projects from Supabase.
  Future<void> loadProjects() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _projects = await _repository.fetchAll();
      _applyFilter();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new project.
  Future<bool> addProject(AdminProjectModel project) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final created = await _repository.create(project);
      _projects.insert(0, created);
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

  /// Updates an existing project.
  Future<bool> updateProject(String originalName, AdminProjectModel project) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updated = await _repository.update(originalName, project);
      final index = _projects.indexWhere((p) => p.name == originalName);
      if (index != -1) {
        _projects[index] = updated;
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

  /// Deletes a project by name.
  Future<bool> deleteProject(String name) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.delete(name);
      _projects.removeWhere((p) => p.name == name);
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
    _filteredProjects = _projects.where((p) {
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery) ||
          p.description.toLowerCase().contains(_searchQuery) ||
          p.companyName.toLowerCase().contains(_searchQuery) ||
          p.technologies.any((t) => t.toLowerCase().contains(_searchQuery));

      final matchesTech = _selectedTechnology == null ||
          p.technologies.contains(_selectedTechnology);

      return matchesSearch && matchesTech;
    }).toList();
  }
}
