import 'package:clean_arc/features---or-----modules/technician/booking/data/model/technician_booking_model.dart';
import 'package:equatable/equatable.dart';

abstract class TechnicianHomeState extends Equatable {
  const TechnicianHomeState();

  @override
  List<Object?> get props => [];
}

class TechnicianHomeInitial extends TechnicianHomeState {}

class TechnicianHomeLoading extends TechnicianHomeState {}

class TechnicianHomeSuccess extends TechnicianHomeState {
  final List<TechnicianBooking> bookings;
  final DateTime selectedDate;

  const TechnicianHomeSuccess({
    required this.bookings,
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [bookings, selectedDate];

  TechnicianHomeSuccess copyWith({
    List<TechnicianBooking>? bookings,
    DateTime? selectedDate,
  }) {
    return TechnicianHomeSuccess(
      bookings: bookings ?? this.bookings,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class TechnicianHomeError extends TechnicianHomeState {
  final String message;

  const TechnicianHomeError(this.message);

  @override
  List<Object?> get props => [message];
}
