import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../network/dio_helper.dart';
import '../network/network_checker.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/data_source/technician_auth_remote_data_source.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/data/data_source/technician_auth_remote_data_source_impl.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/repo/technician_auth_repo.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/domain/repo/technician_auth_repo_impl.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_cubit.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // ── Init Dio ────────────────────────────────
  DioHelper.init();

//Cubits - Blocs - View Models

  /// TECHNICIAN AUTH
  getIt.registerFactory(() => TechnicianRegisterCubit(getIt()));

  /// AUTH (commented stubs)
  // getIt.registerFactory(() => LoginCubit(getIt()));
  // getIt.registerFactory(() => SignUpCubit(getIt()));
  // getIt.registerFactory(() => ForgetPasswordCubit(getIt()));
  // getIt.registerFactory(() => OtpCubit(getIt()));
  // getIt.registerFactory(() => ResetPasswordCubit(getIt()));

//============================================================================//
  /// Repositories
  getIt.registerLazySingleton<TechnicianAuthRepo>(
    () => TechnicianAuthRepoImpl(remoteDataSource: getIt()),
  );
  // getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt(), getIt()));
  // getIt.registerLazySingleton<HomeRepository>(() => HomeRepository(getIt(), getIt()));

//============================================================================//
  ///UseCases
//   getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCase(getIt()));

//============================================================================//
  ///DataSource
  getIt.registerLazySingleton<TechnicianAuthRemoteDataSource>(
    () => TechnicianAuthRemoteDataSourceImpl(),
  );
  // getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  // getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSource());

//============================================================================//
  ///Core
  getIt.registerLazySingleton<NetworkChecker>(
      () => NetworkChecker(internetConnectionChecker: getIt()));

//============================================================================//
//Extra Injection
  // final sharedPreferences = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => InternetConnectionCheckerConstants());
}
