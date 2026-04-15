import 'package:intl/intl.dart';

class DateTimeHelper {
  static String formatTimeAgo(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return '';
    }

    try {
      final DateTime dateTime = DateTime.parse(dateTimeString);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);

      // إذا كان أقل من دقيقة
      if (difference.inMinutes < 1) {
        return 'الآن';
      }

      // إذا كان أقل من ساعة
      if (difference.inHours < 1) {
        final minutes = difference.inMinutes;
        return 'منذ $minutes دقيقة';
      }

      // إذا كان أقل من يوم
      if (difference.inDays < 1) {
        final hours = difference.inHours;
        return 'منذ $hours ساعة';
      }

      // إذا كان أقل من أسبوع
      if (difference.inDays < 7) {
        final days = difference.inDays;
        return 'منذ $days يوم';
      }

      // إذا كان أقل من شهر
      if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return 'منذ $weeks أسبوع';
      }

      // إذا كان أقل من سنة
      if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return 'منذ $months شهر';
      }

      // أكثر من سنة
      final years = (difference.inDays / 365).floor();
      return 'منذ $years سنة';
    } catch (e) {
      // في حالة فشل parsing التاريخ، نعيد التاريخ كما هو
      return dateTimeString;
    }
  }

  static String formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return '';
    }

    try {
      final DateTime dateTime = DateTime.parse(dateTimeString);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);

      // إذا كان اليوم نفسه
      if (difference.inDays == 0) {
        return DateFormat('HH:mm').format(dateTime); // الساعة:الدقيقة
      }

      // إذا كان أمس
      if (difference.inDays == 1) {
        return 'أمس ${DateFormat('HH:mm').format(dateTime)}';
      }

      // إذا كان في نفس السنة
      if (dateTime.year == now.year) {
        return DateFormat(
          'dd/MM HH:mm',
        ).format(dateTime); // اليوم/الشهر الساعة:الدقيقة
      }

      // إذا كان في سنة مختلفة
      return DateFormat(
        'dd/MM/yyyy HH:mm',
      ).format(dateTime); // اليوم/الشهر/السنة الساعة:الدقيقة
    } catch (e) {
      return dateTimeString;
    }
  }

  static String formatDateOnly(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return '';
    }

    try {
      final DateTime dateTime = DateTime.parse(dateTimeString);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);

      // إذا كان اليوم نفسه
      if (difference.inDays == 0) {
        return 'اليوم';
      }

      // إذا كان أمس
      if (difference.inDays == 1) {
        return 'أمس';
      }

      // إذا كان في نفس السنة
      if (dateTime.year == now.year) {
        return DateFormat('dd/MM').format(dateTime); // اليوم/الشهر
      }

      // إذا كان في سنة مختلفة
      return DateFormat('dd/MM/yyyy').format(dateTime); // اليوم/الشهر/السنة
    } catch (e) {
      return dateTimeString;
    }
  }
}
