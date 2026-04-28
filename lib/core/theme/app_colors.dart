import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  APP COLORS — صنايعي
//  Single source of truth for all colors
// ════════════════════════════════════════════════

abstract class AppColors {
  // ── Brand gradient ──
  static const Color violet = Color(0xFF6C63FF);
  static const Color teal = Color(0xFF48CAE4);
  static const Color orange = Color(0xFFFF9F43);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [violet, teal],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [violet, teal],
  );

  // ── Neutrals ──
  static const Color background = Color(0xFFF4F6FA);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textMedium = Color(0xFF555555);
  static const Color textLight = Color(0xFFAAAAAA);
  static const Color divider = Color(0xFFEEEEEE);

  // ── Status ──
  static const Color pending = Color(0xFFFF9F43);
  static const Color approved = Color(0xFF6C63FF);
  static const Color completed = Color(0xFF2ECC71);

  // ── Category icon backgrounds ──
  static const Color catBlue = Color(0xFF48CAE4);
  static const Color catYellow = Color(0xFFFF9F43);
  static const Color catRed = Color(0xFFFF6B6B);
  static const Color catGreen = Color(0xFF2ECC71);
}
