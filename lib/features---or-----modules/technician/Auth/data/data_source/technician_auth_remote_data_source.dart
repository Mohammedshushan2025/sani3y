import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/category_model.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/register_technician_model.dart';

// ════════════════════════════════════════════════
//  TECHNICIAN AUTH REMOTE DATA SOURCE — Abstract
// ════════════════════════════════════════════════

abstract class TechnicianAuthRemoteDataSource {
  /// GET /categories/
  Future<List<CategoryModel>> getCategories();

  /// POST /register/   (multipart/form-data)
  /// Returns the API success message string.
  Future<String> registerTechnician(RegisterTechnicianModel model);
}
