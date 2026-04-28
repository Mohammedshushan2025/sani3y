import 'package:clean_arc/features---or-----modules/technician/booking/data/model/technician_booking_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

abstract class TechnicianBookingRepo {
  Future<Either<Failure, List<TechnicianBooking>>> getBookings(int userID);
}
