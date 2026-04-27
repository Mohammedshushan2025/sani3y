import 'package:clean_arc/features---or-----modules/shared/auth/domain/entities/auth_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/category_entity.dart';

abstract class TechnicianRegisterState {}

// ── Initial ───────────────────────────────────
class TechnicianRegisterInitial extends TechnicianRegisterState {}

// ── Categories ────────────────────────────────
class CategoriesLoadingState extends TechnicianRegisterState {}

class CategoriesSuccessState extends TechnicianRegisterState {
  final List<CategoryEntity> categories;
  CategoriesSuccessState({required this.categories});
}

class CategoriesErrorState extends TechnicianRegisterState {
  final String message;
  CategoriesErrorState({required this.message});
}

// ── Image picker ──────────────────────────────
class ImagePickedState extends TechnicianRegisterState {
  final String imagePath;
  ImagePickedState({required this.imagePath});
}

// ── Registration ──────────────────────────────
class RegisterLoadingState extends TechnicianRegisterState {}

class RegisterSuccessState extends TechnicianRegisterState {
  final String message;
  final AuthEntity auth;
  RegisterSuccessState({required this.message, required this.auth});
}

class RegisterErrorState extends TechnicianRegisterState {
  final String message;
  RegisterErrorState({required this.message});
}
