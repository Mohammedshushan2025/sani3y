import 'package:dartz/dartz.dart';
import 'package:clean_arc/core/errors/exceptions.dart';
import 'package:clean_arc/core/errors/failures.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/data_source/technician_auth_remote_data_source.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/models/register_technician_model.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/category_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/entities/register_technician_entity.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/repo/technician_auth_repo.dart';

import '../../../../shared/auth/domain/entities/auth_entity.dart';

// ════════════════════════════════════════════════
//  TECHNICIAN AUTH REPO — Implementation
// ════════════════════════════════════════════════

class TechnicianAuthRepoImpl implements TechnicianAuthRepo {
  final TechnicianAuthRemoteDataSource remoteDataSource;

  TechnicianAuthRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final List<CategoryEntity> categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.errorModel.getFirstError() ?? 'حدث خطأ في الخادم'),
      );
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> registerTechnician(
      RegisterTechnicianEntity data) async {
    try {
      final model = RegisterTechnicianModel.fromEntity(data);
      final authModel = await remoteDataSource.registerTechnician(model);
      return Right(authModel);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.errorModel.getFirstError() ?? 'حدث خطأ في الخادم'),
      );
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
