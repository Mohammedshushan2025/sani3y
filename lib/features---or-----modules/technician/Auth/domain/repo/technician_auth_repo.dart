import 'package:dartz/dartz.dart';
import 'package:clean_arc/core/errors/failures.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/category_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/register_technician_entity.dart';

// ════════════════════════════════════════════════
//  TECHNICIAN AUTH REPO — Abstract (Domain Layer)
// ════════════════════════════════════════════════

abstract class TechnicianAuthRepo {
  /// Fetches the list of service categories.
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  /// Registers a new technician account.
  /// Returns the API success message on success.
  Future<Either<Failure, String>> registerTechnician(
      RegisterTechnicianEntity data);
}
