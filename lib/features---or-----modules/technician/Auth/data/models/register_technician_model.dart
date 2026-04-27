import 'package:dio/dio.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/register_technician_entity.dart';

// ════════════════════════════════════════════════
//  REGISTER TECHNICIAN MODEL — Data Layer
//  Converts the domain entity → Dio FormData
//  (multipart because of the profile image field).
// ════════════════════════════════════════════════

class RegisterTechnicianModel {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String governorate;
  final String city;
  final int age;
  final int categoryId;
  final String? imagePath;
  final String userType = 'technician';

  RegisterTechnicianModel({
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

  factory RegisterTechnicianModel.fromEntity(
          RegisterTechnicianEntity entity) =>
      RegisterTechnicianModel(
        email: entity.email,
        password: entity.password,
        fullName: entity.fullName,
        phoneNumber: entity.phoneNumber,
        governorate: entity.governorate,
        city: entity.city,
        age: entity.age,
        categoryId: entity.categoryId,
        imagePath: entity.imagePath,
      );

  /// Converts to multipart FormData for Dio.
  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'email': email,
      'password': password,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'governorate': governorate,
      'city': city,
      'age': age.toString(),
      'category': categoryId.toString(),
      'user_type': userType,
    });

    if (imagePath != null && imagePath!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(
            imagePath!,
            filename: imagePath!.split(RegExp(r'[/\\]')).last,
          ),
        ),
      );
    }

    return formData;
  }
}
