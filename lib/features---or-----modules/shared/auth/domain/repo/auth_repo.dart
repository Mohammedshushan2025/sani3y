import 'package:dartz/dartz.dart';
import 'package:clean_arc/core/errors/failures.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, AuthEntity?>> getSavedAuth();

  Future<Either<Failure, void>> saveAuth(AuthEntity auth);
}
