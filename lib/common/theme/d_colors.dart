import 'package:flutter/material.dart';

class DColors {
  // Primary Colors
  static const Color primary = Color(0xFFC6F54C);
  static const Color secondary = Color(0xFF00FFC3);

  // Background Colors
  static const Color backgroundDark = Color(0xFF0A0A0A);
  static const Color backgroundDarkStart = Color(0xFF111111);
  static const Color backgroundDarkEnd = Color(0xFF000000);

  // Glass morphism
  static Color glassBgDark = const Color(0xFF1E1E1E).withOpacity(0.45);
  static Color glassBorder = Colors.white.withOpacity(0.1);

  // Text Colors
  static const Color textDark = Color(0xFFF5F5F7);
  static const Color textMuted = Color(0xFF8A8A8E);

  // Accent Colors
  static const Color pink = Colors.pinkAccent;
  static const Color error = Color(0xFFFF453A);
  static const Color success = Color(0xFF30D158);

  // Shadow Colors
  static Color primaryGlow = primary.withOpacity(0.35);
  static Color secondaryGlow = secondary.withOpacity(0.1);
  static Color blackShadow = Colors.black.withOpacity(0.2);

  DColors._();
}