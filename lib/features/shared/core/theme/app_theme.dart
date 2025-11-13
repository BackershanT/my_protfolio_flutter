import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  bool isDarkMode(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
      default:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }
}

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: GoogleFonts.poppins(color: AppColors.lightText),
      bodyMedium: GoogleFonts.poppins(color: AppColors.lightText),
      bodySmall: GoogleFonts.poppins(color: AppColors.lightText),
      headlineLarge: GoogleFonts.poppins(color: AppColors.lightText, fontWeight: FontWeight.bold),
      headlineMedium: GoogleFonts.poppins(color: AppColors.lightText, fontWeight: FontWeight.bold),
      headlineSmall: GoogleFonts.poppins(color: AppColors.lightText, fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF0A192F)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primaryDark),
        foregroundColor: MaterialStateProperty.all(AppColors.lightBackground),
        textStyle: MaterialStateProperty.all(
          GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: GoogleFonts.poppins(color: AppColors.darkText),
      bodyMedium: GoogleFonts.poppins(color: AppColors.darkText),
      bodySmall: GoogleFonts.poppins(color: AppColors.secondaryText),
      headlineLarge: GoogleFonts.poppins(color: AppColors.darkText, fontWeight: FontWeight.bold),
      headlineMedium: GoogleFonts.poppins(color: AppColors.darkText, fontWeight: FontWeight.bold),
      headlineSmall: GoogleFonts.poppins(color: AppColors.darkText, fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0A192F),
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF64FFDA)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.primaryLight),
        foregroundColor: MaterialStateProperty.all(AppColors.darkBackground),
        textStyle: MaterialStateProperty.all(
          GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
  );
}