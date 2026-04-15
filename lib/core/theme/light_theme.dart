
import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:clean_arc/core/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

ThemeData themeDataLight() => ThemeData(
  fontFamily: 'NotoSansArabic',

  /// لون خلفية التطبيق
  scaffoldBackgroundColor: AppColors.white,

  /// اللون الأساسي للتطبيق
  primaryColor: AppColors.primary,

  /// ألوان النظام الأساسية
  colorScheme:  ColorScheme.light(
    primary: AppColors.primary,
    error: AppColors.red,
  ),

  /// ألوان إضافية مخصصة للتطبيق (خارج ColorScheme الافتراضي)
  extensions:  [
    AppColorsExtension(
      chatText: AppColors.background,
      cardBackground: AppColors.lightBlack,
      borderColor: AppColors.grayColor,
      successColor: Colors.green,
      warningColor: Colors.orange,
    ),
  ],

  appBarTheme:  AppBarTheme(
    backgroundColor: AppColors.primary,
    elevation: 0,

    /// لون الأيقونات داخل الـ AppBar
    iconTheme: IconThemeData(color: AppColors.white),

    /// ستايل عنوان الـ AppBar
    titleTextStyle: TextStyle(
      color: AppColors.darkGrayColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
