import 'package:flutter/material.dart';
import 'package:my_protfolio/features/skills/data/models/skill_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/skill_repository.dart';

class SkillProvider extends ChangeNotifier {
  final SkillRepository _repository = SkillRepository();

  List<SkillModel> _skills = [];
  List<SkillModel> _filteredSkills = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  String _statusFilter = 'all'; // 'all', 'active', 'inactive'

  // Getters
  List<SkillModel> get skills => _filteredSkills;
  List<SkillModel> get allSkills => _skills;

  /// Returns only active skills (for public website)
  List<SkillModel> get activeSkills =>
      _skills.where((s) => s.isActive).toList();

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  String get statusFilter => _statusFilter;

  // Stats
  int get totalCount => _skills.length;
  int get activeCount => _skills.where((s) => s.isActive).length;
  int get inactiveCount => _skills.where((s) => !s.isActive).length;

  /// Loads all skills from Supabase.
  Future<void> loadSkills() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _skills = await _repository.fetchAll();
      _applyFilters();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new skill.
  Future<bool> addSkill(SkillModel skill) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final created = await _repository.create(skill);
      _skills.insert(0, created);
      _applyFilters();
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

  /// Updates an existing skill.
  Future<bool> updateSkill(SkillModel skill) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updated = await _repository.update(skill);
      final index = _skills.indexWhere((s) => s.id == updated.id);
      if (index != -1) {
        _skills[index] = updated;
      }
      _applyFilters();
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

  /// Toggles active status of a skill directly.
  Future<bool> toggleSkillActive(int id, bool isActive) async {
    try {
      final updated = await _repository.toggleActive(id, isActive);
      final index = _skills.indexWhere((s) => s.id == id);
      if (index != -1) {
        _skills[index] = updated;
      }
      _applyFilters();
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  /// Deletes a skill by ID.
  Future<bool> deleteSkill(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.delete(id);
      _skills.removeWhere((s) => s.id == id);
      _applyFilters();
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

  /// Updates the search query and filters skills.
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  /// Sets the status filter ('all', 'active', 'inactive')
  void setStatusFilter(String filter) {
    _statusFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  /// Clears any error messages.
  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _applyFilters() {
    final query = _searchQuery.trim().toLowerCase();

    _filteredSkills = _skills.where((s) {
      final matchesSearch = query.isEmpty || s.name.toLowerCase().contains(query);

      final matchesStatus = switch (_statusFilter) {
        'active' => s.isActive,
        'inactive' => !s.isActive,
        _ => true,
      };

      return matchesSearch && matchesStatus;
    }).toList();
  }
}
