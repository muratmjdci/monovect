
// lib/core/theme/app_shadows.dart
import 'package:flutter/material.dart';

import 'd_colors.dart';

class DShadows {
  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: DColors.primaryGlow,
      blurRadius: 18,
      spreadRadius: 4,
    ),
  ];

  static List<BoxShadow> secondaryGlow = [
    BoxShadow(
      color: DColors.secondaryGlow,
      blurRadius: 18,
      spreadRadius: 4,
    ),
  ];

  static List<BoxShadow> soft = [
    BoxShadow(
      color: DColors.blackShadow,
      blurRadius: 32,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 16,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> elevated = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  DShadows._();
}