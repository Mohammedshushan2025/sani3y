import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.token,
    required super.userId,
    required super.userType,
    super.fullName,
    super.email,
    super.categoryId,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String,
      userId: json['user_id'] as int,
      userType: json['user_type'] as String,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      categoryId: json['category_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user_id': userId,
      'user_type': userType,
      'full_name': fullName,
      'email': email,
      'category_id': categoryId,
    };
  }
}
