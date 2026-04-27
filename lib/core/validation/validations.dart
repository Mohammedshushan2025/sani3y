// ════════════════════════════════════════════════
//  APP VALIDATIONS — صنايعي
//  Pure static validators returning Arabic error
//  strings (no localization dependency needed).
// ════════════════════════════════════════════════

abstract class AppValidations {
  // ── Required field ─────────────────────────────
  static String? validateRequired(String? value, {String fieldName = 'الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    return null;
  }

  // ── Full name ──────────────────────────────────
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الاسم الكامل مطلوب';
    }
    if (value.trim().length < 3) {
      return 'الاسم يجب أن يكون 3 أحرف على الأقل';
    }
    return null;
  }

  // ── Email ──────────────────────────────────────
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    final emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'البريد الإلكتروني غير صحيح';
    }
    return null;
  }

  // ── Password ───────────────────────────────────
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  // ── Confirm password ───────────────────────────
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.trim().isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }
    if (value != password) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  // ── Phone ──────────────────────────────────────
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهاتف مطلوب';
    }
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value.trim())) {
      return 'رقم الهاتف يجب أن يكون بين 10 و 15 رقماً';
    }
    return null;
  }

  // ── Age ────────────────────────────────────────
  static String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'العمر مطلوب';
    }
    final age = int.tryParse(value.trim());
    if (age == null) {
      return 'يرجى إدخال رقم صحيح';
    }
    if (age < 18 || age > 80) {
      return 'العمر يجب أن يكون بين 18 و 80';
    }
    return null;
  }

  // ── OTP ────────────────────────────────────────
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رمز التحقق مطلوب';
    }
    if (value.trim().length < 4) {
      return 'رمز التحقق يجب أن يكون 4 أرقام على الأقل';
    }
    return null;
  }

  // ── National ID ────────────────────────────────
  static String? validateNationalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرقم القومي مطلوب';
    }
    if (!RegExp(r'^[1|2]{1}[0-9]{9}$').hasMatch(value.trim())) {
      return 'الرقم القومي غير صحيح';
    }
    return null;
  }

  // ── Generic min-length ─────────────────────────
  static String? validateMinLength(String? value,
      {required int min, String fieldName = 'الحقل'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    if (value.trim().length < min) {
      return '$fieldName يجب أن يكون $min أحرف على الأقل';
    }
    return null;
  }
}
