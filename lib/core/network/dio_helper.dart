import 'package:dio/dio.dart';

// ════════════════════════════════════════════════
//  DIO HELPER — صنايعي
//  Central HTTP client with timeout, logging, and
//  helpers for GET / POST (JSON + multipart) / PUT / PATCH / DELETE.
// ════════════════════════════════════════════════

class DioHelper {
  static late Dio _dio;

  // ── Initialise once in main() ──────────────────
  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://easyservice.pythonanywhere.com/api/accounts/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }

  // ── Authorization helper ───────────────────────
  static void _setAuth(String? token) {
    if (token != null && token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  // ── GET ───────────────────────────────────────
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _setAuth(token);
    return _dio.get(url, queryParameters: query);
  }

  // ── POST (JSON or FormData/multipart) ─────────
  static Future<Response> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
    bool isFormData = false,
  }) async {
    _setAuth(token);
    return _dio.post(
      url,
      queryParameters: query,
      data: data,
      options: isFormData
          ? Options(contentType: 'multipart/form-data')
          : null,
    );
  }

  // ── PUT ───────────────────────────────────────
  static Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _setAuth(token);
    return _dio.put(url, queryParameters: query, data: data);
  }

  // ── PATCH ─────────────────────────────────────
  static Future<Response> patchData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _setAuth(token);
    return _dio.patch(url, queryParameters: query, data: data);
  }

  // ── DELETE ────────────────────────────────────
  static Future<Response> deleteData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    _setAuth(token);
    return _dio.delete(url, queryParameters: query, data: data);
  }
}
