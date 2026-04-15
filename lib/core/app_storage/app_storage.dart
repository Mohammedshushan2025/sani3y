// import 'dart:convert';
// // import 'package:curva/core/widgets/splach_screen.dart';
// // import 'package:curva/modules/auth/models/user_model.dart';
// // import 'package:curva/modules/auth/presentation/screens/login.dart';
// // import 'package:curva/modules/nav_bar/presentation/bloc/nav_bar_cubit.dart';
// // import 'package:get_storage/get_storage.dart';

// import '../routes/navigator_push.dart';


// class AppStorage {

//   static GetStorage _box = GetStorage();

//   static Future<void> init() async => await GetStorage.init();

//   static Future<void> cacheToken(String value)=> _box.write('token', value);

//   static void cacheId(int id) => _box.write('id', id);

//   static Future<void> cacheUser(UserModel user) async => await _box.write('user', json.encode(user.toJson()));

//   static void cacheStatus(bool status) => _box.write('status', status);

//   static UserModel get getUserModel => UserModel.fromJson(json.decode(_box.read('user')));



//   static String get getToken => _box.read("token");
//   static bool get getStatus => _box.read("status");
//   static bool get isLogged => _box.hasData('token');

//   static void signOut()  {
//     _box.erase();
//     NavBarCubit.of(RouteManager.currentContext).currentIndex = 0;
//     RouteManager.navigateAndPopAll(LoginScreen());
//   }

// }



