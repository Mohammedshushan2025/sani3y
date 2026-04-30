import 'package:clean_arc/core/enums/booking_status.dart';

abstract class TechnicianBookingState {}

class TechnicianBookingInitial extends TechnicianBookingState {}

class TechnicianBookingTabChanged extends TechnicianBookingState {
  final int index;
  TechnicianBookingTabChanged(this.index);
}

class TechnicianBookingStatusLoading extends TechnicianBookingState {
  final int bookingId;
  final BookingStatus status;
  TechnicianBookingStatusLoading(this.bookingId, this.status);
}

class TechnicianBookingStatusSuccess extends TechnicianBookingState {
  final int bookingId;
  final BookingStatus status;
  TechnicianBookingStatusSuccess(this.bookingId, this.status);
}

class TechnicianBookingStatusError extends TechnicianBookingState {
  final String message;
  TechnicianBookingStatusError(this.message);
}
