import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuth(AuthModel auth);
  Future<AuthModel?> getAuth();
  Future<void> clearAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _authKey = 'auth_session';

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveAuth(AuthModel auth) async {
    final jsonStr = json.encode(auth.toJson());
    await secureStorage.write(key: _authKey, value: jsonStr);
  }

  @override
  Future<AuthModel?> getAuth() async {
    final jsonStr = await secureStorage.read(key: _authKey);
    if (jsonStr != null) {
      return AuthModel.fromJson(json.decode(jsonStr) as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<void> clearAuth() async {
    await secureStorage.delete(key: _authKey);
  }
}
