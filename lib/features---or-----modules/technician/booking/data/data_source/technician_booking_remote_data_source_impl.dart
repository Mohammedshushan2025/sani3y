import 'package:clean_arc/core/enums/booking_status.dart';
import 'package:dio/dio.dart';
import 'package:clean_arc/core/errors/exceptions.dart';
import 'package:clean_arc/core/network/api_constant.dart';
import 'package:clean_arc/core/network/api_response_wrapper.dart';
import 'package:clean_arc/core/network/dio_helper.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/model/technician_booking_model.dart';
import 'technician_booking_remote_data_source.dart';

class TechnicianBookingRemoteDataSourceImpl implements TechnicianBookingRemoteDataSource {
  @override
  Future<List<TechnicianBooking>> getBookings(int userID) async {
    try {
      final response = await DioHelper.getData(
        url: ApiConstants.bookingTechnicianURL.replaceFirst('{user_id}', userID.toString()),
      );

      final apiResponse = ApiResponse<List<TechnicianBooking>>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => (data as List<dynamic>)
            .map((e) => TechnicianBooking.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      return apiResponse.data ?? [];
    } on DioException catch (e) {
      handelDioException(e);
      rethrow;
    }
  }

  @override
  Future<void> updateBookingStatus(int bookingId, BookingStatus status) async {
    try {
      await DioHelper.postData(
        url: ApiConstants.bookingUpdateStatusURL,
        data: {
          'booking_id': bookingId,
          'status': status.name, // "accepted" or "rejected"
        },
      );
    } on DioException catch (e) {
      handelDioException(e);
      rethrow;
    }
  }
}