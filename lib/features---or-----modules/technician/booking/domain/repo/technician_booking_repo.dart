import 'package:clean_arc/core/enums/booking_status.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/model/technician_booking_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

abstract class TechnicianBookingRepo {
  Future<Either<Failure, List<TechnicianBooking>>> getBookings(int userID);
  Future<Either<Failure, void>> updateBookingStatus(int bookingId, BookingStatus status);
}
