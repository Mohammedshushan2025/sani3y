// ════════════════════════════════════════════════
//  REGISTER TECHNICIAN ENTITY — Domain Layer
// ════════════════════════════════════════════════

class RegisterTechnicianEntity {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String governorate;
  final String city;
  final int age;
  final int categoryId;
  final String? imagePath;

  const RegisterTechnicianEntity({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.governorate,
    required this.city,
    required this.age,
    required this.categoryId,
    this.imagePath,
  });
}
