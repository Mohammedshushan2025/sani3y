import 'package:clean_arc/features---or-----modules/shared/auth/data/models/auth_model.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/category_model.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/register_technician_model.dart';

abstract class TechnicianAuthRemoteDataSource {
  Future<List<CategoryModel>> getCategories();

  Future<AuthModel> registerTechnician(RegisterTechnicianModel model);
}
