import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:clean_arc/core/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

ThemeData themeDataDark() => ThemeData(
  fontFamily: 'NotoSansArabic',

  /// لون خلفية التطبيق في الوضع الداكن
  scaffoldBackgroundColor: AppColors.darkGrayColor,

  primaryColor: AppColors.primary,

  colorScheme:  ColorScheme.dark(
    primary: AppColors.primary,
    error: AppColors.red,
  ),

  /// ألوان إضافية مخصصة للتطبيق (خارج ColorScheme الافتراضي)
  extensions:  [
    AppColorsExtension(
      chatText: AppColors.textColor,
      cardBackground: AppColors.textColor,
      borderColor: AppColors.textColor,
      successColor: Colors.green,
      warningColor: Colors.orange,
    ),
  ],

  appBarTheme:  AppBarTheme(
    backgroundColor: AppColors.darkGrayColor,
    elevation: 0,

    /// لون الأيقونات
    iconTheme: IconThemeData(color: AppColors.white),

    /// عنوان الـ AppBar
    titleTextStyle: TextStyle(
      color: AppColors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
