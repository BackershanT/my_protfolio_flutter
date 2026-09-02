import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_protfolio/core/theme/app_theme.dart';
import 'package:my_protfolio/features/shared/data/models/certification_data.dart';
import 'package:my_protfolio/features/projects/data/models/project_data.dart';

void main() {
  group('Portfolio Core Tests', () {
    test('ThemeProvider initializes with light mode and toggles correctly', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.themeMode, equals(ThemeMode.light));

      themeProvider.toggleTheme(true);
      expect(themeProvider.themeMode, equals(ThemeMode.dark));

      themeProvider.toggleTheme(false);
      expect(themeProvider.themeMode, equals(ThemeMode.light));

      themeProvider.setThemeMode(ThemeMode.system);
      expect(themeProvider.themeMode, equals(ThemeMode.system));
    });

    test('ProjectData returns projects list with valid data', () {
      final projects = ProjectData.getAllProjects();
      expect(projects, isNotEmpty);
      for (final p in projects) {
        expect(p.title, isNotEmpty);
        expect(p.description, isNotEmpty);
      }
    });

    test('CertificationData returns certifications list', () {
      final certs = CertificationData.getAllCertifications();
      expect(certs, isA<List>());
    });
  });
}
