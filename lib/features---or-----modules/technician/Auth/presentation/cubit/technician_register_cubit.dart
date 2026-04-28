import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/category_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/register_technician_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/repo/technician_auth_repo.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/auth_cubit.dart';
import 'technician_register_state.dart';



class TechnicianRegisterCubit extends Cubit<TechnicianRegisterState> {
  final TechnicianAuthRepo _repo;
  final ImagePicker _imagePicker = ImagePicker();

  // Persisted across state transitions
  List<CategoryEntity> categories = [];
  String? pickedImagePath;

  TechnicianRegisterCubit(this._repo) : super(TechnicianRegisterInitial());

  static TechnicianRegisterCubit of(context) =>
      BlocProvider.of<TechnicianRegisterCubit>(context);

  // ── Fetch categories ───────────────────────────
  Future<void> fetchCategories() async {
    emit(CategoriesLoadingState());
    final result = await _repo.getCategories();
    result.fold(
      (failure) => emit(CategoriesErrorState(message: failure.message)),
      (data) {
        categories = data;
        emit(CategoriesSuccessState(categories: data));
      },
    );
  }

  // ── Pick profile image from gallery ───────────
  Future<void> pickImage() async {
    final XFile? picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      pickedImagePath = picked.path;
      emit(ImagePickedState(imagePath: picked.path));
    }
  }

  // ── Register technician ────────────────────────
  Future<void> register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String governorate,
    required String city,
    required String age,
    required int categoryId,
  }) async {
    emit(RegisterLoadingState());

    final entity = RegisterTechnicianEntity(
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      governorate: governorate,
      city: city,
      age: int.parse(age),
      categoryId: categoryId,
      imagePath: pickedImagePath,
    );

    final result = await _repo.registerTechnician(entity);
    result.fold(
      (failure) => emit(RegisterErrorState(message: failure.message)),
      (auth) => emit(RegisterSuccessState(message: 'تم إنشاء الحساب بنجاح', auth: auth)),
    );
  }
}
