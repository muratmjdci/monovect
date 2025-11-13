import 'package:flutter/material.dart';

import 'd_colors.dart';

class DDecorations {
  // Glassmorphic Container
  static BoxDecoration glassmorphic({
    BorderRadius? borderRadius,
    Color? color,
    Border? border,
  }) {
    return BoxDecoration(
      color: color ?? DColors.glassBgDark,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      border: border ?? Border.all(color: DColors.glassBorder, width: 1),
      boxShadow: [BoxShadow(color: DColors.blackShadow, blurRadius: 32)],
    );
  }

  // Primary Glow Border
  static BoxDecoration primaryGlow({
    BorderRadius? borderRadius,
    Color? borderColor,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      border: Border.all(color: borderColor ?? DColors.primary, width: 1),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          DColors.primary.withOpacity(0.1),
          DColors.secondary.withOpacity(0.1),
        ],
      ),
      boxShadow: [
        BoxShadow(color: DColors.primaryGlow, blurRadius: 18, spreadRadius: 4),
      ],
    );
  }

  // Secondary Glow Border
  static BoxDecoration secondaryGlow({BorderRadius? borderRadius}) {
    return BoxDecoration(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      border: Border.all(color: DColors.secondary, width: 1),
      boxShadow: [
        BoxShadow(
          color: DColors.secondaryGlow,
          blurRadius: 18,
          spreadRadius: 4,
        ),
      ],
    );
  }

  // Card Decoration
  static BoxDecoration card({BorderRadius? borderRadius}) {
    return BoxDecoration(
      color: DColors.glassBgDark,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      border: Border.all(color: DColors.glassBorder, width: 1),
    );
  }

  // Gradient Background
  static BoxDecoration gradientBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [DColors.backgroundDarkStart, DColors.backgroundDarkEnd],
      ),
    );
  }

  DDecorations._();
}
