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

  // Getters
  List<SkillModel> get skills =>
      _searchQuery.isEmpty ? _skills : _filteredSkills;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  // Stats
  int get totalCount => _skills.length;

  /// Loads all skills from Supabase.
  Future<void> loadSkills() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _skills = await _repository.fetchAll();
      // If we don't have any skills from DB yet, we could potentially seed them from SkillData,
      // but for now we'll just show what's in the DB.
      _applySearchFilter();
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

  /// Deletes a skill by ID.
  Future<bool> deleteSkill(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.delete(id);
      _skills.removeWhere((s) => s.id == id);
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

  /// Updates the search query and filters skills.
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
      _filteredSkills = _skills;
      return;
    }

    final query = _searchQuery.toLowerCase();
    _filteredSkills = _skills.where((s) {
      return s.name.toLowerCase().contains(query);
    }).toList();
  }
}
