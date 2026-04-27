class AuthEntity {
  final String token;
  final int userId;
  final String userType;
  final int? categoryId;

  const AuthEntity({
    required this.token,
    required this.userId,
    required this.userType,
    this.categoryId,
  });

  bool get isTechnician => userType == 'technician';
}
