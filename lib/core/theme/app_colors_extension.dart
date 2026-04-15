import 'package:flutter/material.dart';

/// امتداد ألوان إضافي للتطبيق.
///
/// الفكرة: نخزن الألوان المخصصة داخل Theme نفسه بدل توزيعها في أماكن متفرقة.
/// بهذه الطريقة يصبح دعم الـ Light / Dark Theme أسهل وأكثر تنظيمًا.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color chatText;
  final Color cardBackground;
  final Color borderColor;
  final Color successColor;
  final Color warningColor;

  const AppColorsExtension({
    required this.chatText,
    required this.cardBackground,
    required this.borderColor,
    required this.successColor,
    required this.warningColor,
  });

  @override
  AppColorsExtension copyWith({
    Color? chatText,
    Color? cardBackground,
    Color? borderColor,
    Color? successColor,
    Color? warningColor,
  }) {
    return AppColorsExtension(
      chatText: chatText ?? this.chatText,
      cardBackground: cardBackground ?? this.cardBackground,
      borderColor: borderColor ?? this.borderColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;

    return AppColorsExtension(
      chatText: Color.lerp(chatText, other.chatText, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
    );
  }
}

