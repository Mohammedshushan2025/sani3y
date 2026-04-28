class AuthEntity {
  final String token;
  final int userId;
  final String userType;
  final String? fullName;
  final String? email;
  final int? categoryId;

  const AuthEntity({
    required this.token,
    required this.userId,
    required this.userType,
    this.fullName,
    this.email,
    this.categoryId,
  });

  bool get isTechnician => userType == 'technician';
}
