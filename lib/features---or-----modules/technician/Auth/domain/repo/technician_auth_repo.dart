import 'package:clean_arc/features---or-----modules/shared/auth/domain/entities/auth_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/category_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/register_technician_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

abstract class TechnicianAuthRepo {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  Future<Either<Failure, AuthEntity>> registerTechnician(
      RegisterTechnicianEntity data);
}
