import 'package:dio/dio.dart';
import 'package:clean_arc/core/errors/exceptions.dart';
import 'package:clean_arc/core/network/api_constant.dart';
import 'package:clean_arc/core/network/api_response_wrapper.dart';
import 'package:clean_arc/core/network/dio_helper.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/category_model.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/register_technician_model.dart';
import '../../../../../core/errors/error_model.dart';
import '../../../../shared/auth/data/models/auth_model.dart';
import 'technician_auth_remote_data_source.dart';


class TechnicianAuthRemoteDataSourceImpl
    implements TechnicianAuthRemoteDataSource {
  // ── GET /categories/ ──────────────────────────
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response =
          await DioHelper.getData(url: ApiConstants.categoriesURL);

      final apiResponse = ApiResponse<List<CategoryModel>>.fromJson(
        response.data as Map<String, dynamic>,
        (data) => (data as List<dynamic>)
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      return apiResponse.data ?? [];
    } on DioException catch (e) {
      handelDioException(e);
      rethrow;
    }
  }

  // ── POST /register/ ───────────────────────────
  @override
  Future<AuthModel> registerTechnician(RegisterTechnicianModel model) async {
    try {
      final formData = await model.toFormData();

      final response = await DioHelper.postData(
        url: ApiConstants.registerURL,
        data: formData,
        isFormData: true,
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
