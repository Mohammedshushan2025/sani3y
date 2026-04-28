// ════════════════════════════════════════════════
//  APP VALIDATIONS — صنايعي
//  Pure static validators returning Arabic error
//  strings (no localization dependency needed).
// ════════════════════════════════════════════════

import 'package:easy_localization/easy_localization.dart';

abstract class AppValidations {
  // ── Required field ─────────────────────────────
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? '$fieldName ${'validation_required'.tr()}' : 'validation_required'.tr();
    }
    return null;
  }

  // ── Full name ──────────────────────────────────
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation_fullname_required'.tr();
    }
    if (value.trim().length < 3) {
      return 'validation_fullname_short'.tr();
    }
    return null;
  }

  // ── Email ──────────────────────────────────────
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation_email_required'.tr();
    }
    final emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'validation_email_invalid'.tr();
    }
    return null;
  }

  // ── Password ───────────────────────────────────
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation_password_required'.tr();
    }
    if (value.length < 6) {
      return 'validation_password_short'.tr();
    }
    return null;
  }

  // ── Confirm password ───────────────────────────
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.trim().isEmpty) {
      return 'validation_password_required'.tr(); // Or a specific key
    }
    if (value != password) {
      return 'password_mismatch'.tr();
    }
    return null;
  }

  // ── Phone ──────────────────────────────────────
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation_phone_required'.tr();
    }
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value.trim())) {
      return 'validation_phone_invalid'.tr();
    }
    return null;
  }

  // ── Age ────────────────────────────────────────
  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validation_age_required'.tr();
    }
    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'validation_age_invalid'.tr();
    }
    if (age < 18 || age > 80) {
      return 'validation_age_range'.tr();
    }
    return null;
  }

  // ── OTP ────────────────────────────────────────
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'otp_required'.tr();
    }
    if (value.trim().length < 4) {
      return 'otp_short'.tr();
    }
    return null;
  }

  // ── National ID ────────────────────────────────
  static String? validateNationalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'national_id_required'.tr();
    }
    if (!RegExp(r'^[1|2]{1}[0-9]{9}$').hasMatch(value.trim())) {
      return 'national_id_invalid'.tr();
    }
    return null;
  }
}
