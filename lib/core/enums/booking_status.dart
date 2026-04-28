import 'package:easy_localization/easy_localization.dart';

enum BookingStatus {
  pending,
  accepted,
  rejected,
  completed;

  String get displayName {
    switch (this) {
      case BookingStatus.pending:
        return 'pending'.tr();
      case BookingStatus.accepted:
        return 'accepted'.tr();
      case BookingStatus.rejected:
        return 'rejected'.tr();
      case BookingStatus.completed:
        return 'completed'.tr();
    }
  }
}
