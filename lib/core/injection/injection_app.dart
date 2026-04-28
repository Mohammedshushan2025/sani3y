import 'package:clean_arc/features---or-----modules/shared/auth/data/data_source/auth_local_data_source.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/data/data_source/auth_remote_data_source.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/data/repository/auth_repo_impl.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/domain/repo/auth_repo.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../network/dio_helper.dart';
import '../network/network_checker.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/data_source/technician_auth_remote_data_source.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/data_source/technician_auth_remote_data_source_impl.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/repo/technician_auth_repo.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/repo/technician_auth_repo_impl.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/data_source/technician_booking_remote_data_source.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/data_source/technician_booking_remote_data_source_impl.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/data/repo/technician_booking_repo_impl.dart';
import 'package:clean_arc/features---or-----modules/technician/booking/domain/repo/technician_booking_repo.dart';
import 'package:clean_arc/features---or-----modules/technician/home/presentation/cubit/technician_home_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // ── Init Dio ────────────────────────────────
  DioHelper.init();

//Cubits - Blocs - View Models

  /// AUTH (Shared)
  getIt.registerLazySingleton(() => AuthCubit(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));

  /// TECHNICIAN AUTH
  getIt.registerFactory(() => TechnicianRegisterCubit(getIt()));
  getIt.registerFactory(() => TechnicianHomeCubit(getIt()));

  /// AUTH (commented stubs)
  // getIt.registerFactory(() => LoginCubit(getIt()));
  // getIt.registerFactory(() => SignUpCubit(getIt()));
  // getIt.registerFactory(() => ForgetPasswordCubit(getIt()));
  // getIt.registerFactory(() => OtpCubit(getIt()));
  // getIt.registerFactory(() => ResetPasswordCubit(getIt()));

//============================================================================//
  /// Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(remoteDataSource: getIt(), localDataSource: getIt()),
  );
  getIt.registerLazySingleton<TechnicianAuthRepo>(
    () => TechnicianAuthRepoImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<TechnicianBookingRepo>(
    () => TechnicianBookingRepoImpl(getIt()),
  );
  // getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt(), getIt()));
  // getIt.registerLazySingleton<HomeRepository>(() => HomeRepository(getIt(), getIt()));

//============================================================================//
  ///UseCases
//   getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCase(getIt()));

//============================================================================//
  ///DataSource
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: getIt()),
  );
  getIt.registerLazySingleton<TechnicianAuthRemoteDataSource>(
    () => TechnicianAuthRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<TechnicianBookingRemoteDataSource>(
    () => TechnicianBookingRemoteDataSourceImpl(),
  );
  // getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  // getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSource());

//============================================================================//
  ///Core
  getIt.registerLazySingleton<NetworkChecker>(
      () => NetworkChecker(internetConnectionChecker: getIt()));

//============================================================================//
//Extra Injection
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => InternetConnectionCheckerConstants());
}
