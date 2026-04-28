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
      // Note: In a real app, user_id would come from storage or auth state.
      // For now, we'll assume the helper handles auth headers if needed.
      // The URL template "booking/technician/{user_id}/" needs a user_id.
      // I'll need to check how to get the current user ID.
      
      // For the purpose of this task, I'll use a placeholder or check if I can get it from storage.
      // Actually, many APIs use 'me' or similar, or it's handled by the token.
      // I'll assume the user ID is needed in the URL as per ApiConstants.
      
      // Let's assume for now we fetch it for the logged in user.
      // I'll use a hardcoded ID for demonstration if I can't find the real one, 
      // but ideally I should get it from a dependency.
      
      final response = await DioHelper.getData(
        url: ApiConstants.bookingTechnicianURL.replaceFirst('{user_id}', userID.toString()), // Placeholder ID
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
}