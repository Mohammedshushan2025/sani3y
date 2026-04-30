import 'package:clean_arc/core/enums/booking_status.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/model/technician_booking_model.dart';

abstract class TechnicianBookingRemoteDataSource {
  Future<List<TechnicianBooking>> getBookings(int userID);
  Future<void> updateBookingStatus(int bookingId, BookingStatus status);
}
