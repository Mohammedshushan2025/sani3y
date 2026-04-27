import 'package:dio/dio.dart';
import 'package:clean_arc/core/errors/exceptions.dart';
import 'package:clean_arc/core/network/api_constant.dart';
import 'package:clean_arc/core/network/api_response_wrapper.dart';
import 'package:clean_arc/core/network/dio_helper.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/category_model.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/register_technician_model.dart';
import 'technician_auth_remote_data_source.dart';

// ════════════════════════════════════════════════
//  TECHNICIAN AUTH REMOTE DATA SOURCE — Impl
// ════════════════════════════════════════════════

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
  Future<String> registerTechnician(RegisterTechnicianModel model) async {
    try {
      final formData = await model.toFormData();

      final response = await DioHelper.postData(
        url: ApiConstants.registerURL,
        data: formData,
        isFormData: true,
      );

      final apiResponse = ApiResponse<dynamic>.fromJson(
        response.data as Map<String, dynamic>,
        null,
      );

      return apiResponse.message;
    } on DioException catch (e) {
      handelDioException(e);
      rethrow;
    }
  }
}
