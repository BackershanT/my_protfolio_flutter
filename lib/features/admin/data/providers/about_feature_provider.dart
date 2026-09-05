import 'package:flutter/material.dart';
import 'package:my_protfolio/features/admin/data/models/about_feature_model.dart';
import 'package:my_protfolio/features/admin/data/repositories/about_feature_repository.dart';

class AboutFeatureProvider extends ChangeNotifier {
  final AboutFeatureRepository _repository = AboutFeatureRepository();

  List<AboutFeatureModel> _features = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<AboutFeatureModel> get features => _features;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadFeatures() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _features = await _repository.fetchAll();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addFeature(AboutFeatureModel feature) async {
    try {
      final created = await _repository.create(feature);
      _features.add(created);
      _features.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateFeature(String id, AboutFeatureModel feature) async {
    try {
      final updated = await _repository.update(id, feature);
      final index = _features.indexWhere((f) => f.id == id);
      if (index != -1) {
        _features[index] = updated;
        _features.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteFeature(String id) async {
    try {
      await _repository.delete(id);
      _features.removeWhere((f) => f.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }
}
