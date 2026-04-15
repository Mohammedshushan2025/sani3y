// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../routes/navigator_push.dart';


String getIcon(String imageName) => 'assets/icon/$imageName.png';
String getAsset(String imageName) => 'assets/images/$imageName.png';
String getLottie(String lottieName) => 'assets/lottie/$lottieName.json';

// bool isEn = RouteManager.currentContext.locale.languageCode == 'en';

// String dashboardURL = "https://itarah-beta.dafa.sa";

void closeKeyboard ()=> FocusManager.instance.primaryFocus?.unfocus();

late  double theHeight =MediaQuery.of(RouteManager.currentContext).size.height;
late double theWidth =MediaQuery.of(RouteManager.currentContext).size.width;

double sizeFromHeight(double fraction,
    {bool removeAppBarSize = true}) {
  MediaQueryData mediaQuery = MediaQuery.of(RouteManager.currentContext);
  fraction = (removeAppBarSize
      ? (mediaQuery.size.height -
      AppBar().preferredSize.height -
      mediaQuery.padding.top)
      : mediaQuery.size.height) /
      (fraction == 0 ? 1 : fraction);
  return fraction;
}

double sizeFromWidth(double fraction) {
  fraction = MediaQuery.of(RouteManager.currentContext).size.width / (fraction == 0 ? 1 : fraction);
  return fraction;
}




String reformatDate(DateTime? value){
  if(value == null) return '';
  final reformatted = value.year.toString() + '-' + value.month.toString().padLeft(2,'0') + '-' + value.day.toString().padLeft(2,'0');
  return reformatted;
}
//
// void recallData(){
//   BlocProvider.of<SettingCubit>(RouteManager.currentContext).getSetting();
//   BlocProvider.of<CountriesCubit>(RouteManager.currentContext).getCountries();
//   BlocProvider.of<TeamsBloc>(RouteManager.currentContext).add(GetTeamsData());
//   BlocProvider.of<HomeBloc>(RouteManager.currentContext).add(GetHomeData());
//   BlocProvider.of<NewsBloc>(RouteManager.currentContext).add(GetNewsData());
//   BlocProvider.of<PlayersBloc>(RouteManager.currentContext).add(GetPlayersData());
//   BlocProvider.of<MatchesBloc>(RouteManager.currentContext).add(GetMatchesData());
//   BlocProvider.of<LeaguesBloc>(RouteManager.currentContext).add(GetLeaguesData());
//   BlocProvider.of<FollowingPlayersBloc>(RouteManager.currentContext).add(GetFollowingPlayersData());
//   BlocProvider.of<FollowingTeamsBloc>(RouteManager.currentContext).add(GetFollowingTeamsData());
//   BlocProvider.of<FollowingLeaguesBloc>(RouteManager.currentContext).add(GetFollowingLeaguesData());
//   BlocProvider.of<FavoritesPlayersBloc>(RouteManager.currentContext).add(GetFavoritesPlayersData());
//   BlocProvider.of<FavoritesTeamsBloc>(RouteManager.currentContext).add(GetFavoritesTeamsData());
//   BlocProvider.of<FavoritesLeaguesBloc>(RouteManager.currentContext).add(GetFavoritesLeaguesData());
//   BlocProvider.of<NotificationsBloc>(RouteManager.currentContext).add(GetNotificationsData());
//   BlocProvider.of<PackagesCubit>(RouteManager.currentContext).getPackages();
//   BlocProvider.of<MyPackagesCubit>(RouteManager.currentContext).getMyPackages();
//
// }

// Future<void> launchFunction({required String url}) async {
//   if (!await launchUrl(Uri.parse(url))) {
//     throw Exception('Could not launch $url');
//   }
// }

// Future<void> launchFunction({required String url}) async {
//   if (!await launchUrl(
//     Uri.parse(url),

//   )) {
//     throw Exception('Could not launch $url');
//   }
// }