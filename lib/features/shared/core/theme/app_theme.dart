import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

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
  static ThemeData getTheme(BuildContext context, bool isDark) {
    final bool isArabic = context.locale.languageCode == 'ar';
    final textTheme = isArabic
        ? GoogleFonts.cairoTextTheme()
        : GoogleFonts.poppinsTextTheme();

    final Color textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final Color secondaryTextColor = isDark
        ? AppColors.secondaryText
        : AppColors.lightText.withOpacity(0.7);

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: isDark ? AppColors.primaryLight : AppColors.primaryDark,
      scaffoldBackgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      textTheme: textTheme.copyWith(
        bodyLarge: (isArabic ? GoogleFonts.cairo() : GoogleFonts.poppins())
            .copyWith(color: textColor),
        bodyMedium: (isArabic ? GoogleFonts.cairo() : GoogleFonts.poppins())
            .copyWith(color: textColor),
        bodySmall: (isArabic ? GoogleFonts.cairo() : GoogleFonts.poppins())
            .copyWith(color: secondaryTextColor),
        headlineLarge: (isArabic ? GoogleFonts.cairo() : GoogleFonts.poppins())
            .copyWith(color: textColor, fontWeight: FontWeight.bold),
        headlineMedium: (isArabic ? GoogleFonts.cairo() : GoogleFonts.poppins())
            .copyWith(color: textColor, fontWeight: FontWeight.bold),
        headlineSmall: (isArabic ? GoogleFonts.cairo() : GoogleFonts.poppins())
            .copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF0A192F) : Colors.white,
        elevation: 0,
      ),
      iconTheme: IconThemeData(
        color: isDark ? const Color(0xFF64FFDA) : const Color(0xFF0A192F),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isDark ? AppColors.primaryLight : AppColors.primaryDark,
          ),
          foregroundColor: MaterialStateProperty.all(
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
          ),
          textStyle: MaterialStateProperty.all(
            (isArabic ? GoogleFonts.cairo() : GoogleFonts.poppins()).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }

  static final lightTheme = ThemeData(
    // Keeping these for backward compatibility if needed,
    // but getTheme is now the preferred way.
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: GoogleFonts.poppins(color: AppColors.lightText),
      bodyMedium: GoogleFonts.poppins(color: AppColors.lightText),
      bodySmall: GoogleFonts.poppins(color: AppColors.lightText),
      headlineLarge: GoogleFonts.poppins(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.poppins(
        color: AppColors.lightText,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
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
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
      headlineLarge: GoogleFonts.poppins(
        color: AppColors.darkText,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: AppColors.darkText,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.poppins(
        color: AppColors.darkText,
        fontWeight: FontWeight.bold,
      ),
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
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
  );
}
