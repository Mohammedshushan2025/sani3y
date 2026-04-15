import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../network/network_checker.dart';

final getIt = GetIt.instance;

Future<void> init() async {
//Cubits - Blocs - View Models
 

  /// AUTH
  // getIt.registerFactory(() => LoginCubit(getIt()));
  // getIt.registerFactory(() => SignUpCubit(getIt()));
  // getIt.registerFactory(() => ForgetPasswordCubit(getIt()));
  // getIt.registerFactory(() => OtpCubit(getIt()));
  // getIt.registerFactory(() => ResetPasswordCubit(getIt()));



//============================================================================//
/// Repositories
  // getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt(), getIt()));
  // getIt.registerLazySingleton<HomeRepository>(() => HomeRepository(getIt(), getIt()));
 
//============================================================================//
///UseCases
//   getIt.registerLazySingleton<AuthUseCase>(() => AuthUseCase(getIt()));


//============================================================================//
///DataSource
  // getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  // getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSource());
  


//============================================================================//
///Core
  getIt.registerLazySingleton<NetworkChecker>(() => NetworkChecker(internetConnectionChecker: getIt()));

//============================================================================//
//Extra Injection
  // final sharedPreferences = await SharedPreferences.getInstance();
  // getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => InternetConnectionCheckerConstants());
}
