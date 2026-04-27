import 'package:dartz/dartz.dart';
import 'package:clean_arc/core/errors/exceptions.dart';
import 'package:clean_arc/core/errors/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/auth_model.dart';


class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final authModel = await remoteDataSource.login(
        email: email,
        password: password,
      );
      await localDataSource.saveAuth(authModel);
      return Right(authModel);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.errorModel.getFirstError() ?? 'حدث خطأ في الخادم'),
      );
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearAuth();
      return const Right(null);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, AuthEntity?>> getSavedAuth() async {
    try {
      final authModel = await localDataSource.getAuth();
      return Right(authModel);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveAuth(AuthEntity auth) async {
    try {
      if (auth is AuthModel) {
        await localDataSource.saveAuth(auth);
      } else {
        await localDataSource.saveAuth(AuthModel(
          token: auth.token,
          userId: auth.userId,
          userType: auth.userType,
          categoryId: auth.categoryId,
        ));
      }
      return const Right(null);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
