import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/d_colors.dart';
import '../theme/d_text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: DColors.backgroundDark,
      fontFamily: 'Inter',

      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: DColors.primary,
        secondary: DColors.secondary,
        surface: DColors.glassBgDark,
        background: DColors.backgroundDark,
        error: DColors.error,
        onPrimary: DColors.backgroundDark,
        onSecondary: DColors.backgroundDark,
        onSurface: DColors.textDark,
        onBackground: DColors.textDark,
        onError: Colors.white,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: DTextStyles.h1,
        displayMedium: DTextStyles.h2,
        displaySmall: DTextStyles.h3,
        headlineMedium: DTextStyles.h4,
        bodyLarge: DTextStyles.bodyLarge,
        bodyMedium: DTextStyles.bodyMedium,
        bodySmall: DTextStyles.bodySmall,
        labelLarge: DTextStyles.buttonMedium,
        labelMedium: DTextStyles.label,
        labelSmall: DTextStyles.labelSmall,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: DColors.textDark,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: DColors.textDark, size: 24),
        titleTextStyle: DTextStyles.brandTitle,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: DColors.glassBgDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: DColors.glassBorder, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DColors.primary,
          foregroundColor: DColors.backgroundDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: DTextStyles.buttonMedium,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: DTextStyles.buttonMedium,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DColors.textDark,
          side: BorderSide(color: DColors.glassBorder),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: DTextStyles.buttonMedium,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DColors.glassBgDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: DColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: DColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: DTextStyles.bodyMedium.copyWith(color: DColors.textMuted),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: DColors.textDark, size: 24),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: DColors.glassBorder,
        thickness: 1,
        space: 1,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: DColors.glassBgDark,
        selectedItemColor: DColors.primary,
        unselectedItemColor: DColors.textMuted,
        selectedLabelStyle: DTextStyles.navLabel,
        unselectedLabelStyle: DTextStyles.navLabel,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
