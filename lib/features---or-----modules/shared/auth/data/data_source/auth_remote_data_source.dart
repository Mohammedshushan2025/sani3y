import 'package:dio/dio.dart';
import 'package:clean_arc/core/errors/exceptions.dart';
import 'package:clean_arc/core/network/api_constant.dart';
import 'package:clean_arc/core/network/api_response_wrapper.dart';
import 'package:clean_arc/core/network/dio_helper.dart';
import '../../../../../core/errors/error_model.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: ApiConstants.loginURL,
        data: {
          'email': email,
          'password': password,
        },
      );

      final apiResponse = ApiResponse<AuthModel>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => AuthModel.fromJson(data as Map<String, dynamic>),
      );

      if (apiResponse.data == null) {
        throw ServerException(
          errorModel: ErrorModel(message: apiResponse.message, status: apiResponse.success.toString()),
        );
      }

      return apiResponse.data!;
    } on DioException catch (e) {
      handelDioException(e);
      rethrow;
    }
  }
}
