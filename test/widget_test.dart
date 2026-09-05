import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_protfolio/core/theme/app_theme.dart';

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
  });
}
