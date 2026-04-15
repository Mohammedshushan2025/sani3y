import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //Main app colors
    primaryColor: AppColors.primary, //Primary color for app
    // errorColor: ColorApp.error, //Error color for app
    disabledColor: AppColors.hintColor, //Disabled color for widgets
    fontFamily: "NeoSansArabic",
    // splashColor: ColorApp.primary, //Splash color for widgets
    // backgroundColor: ColorApp.background, //Background color for widgets
    scaffoldBackgroundColor: AppColors.scaffoldBackground, //Background color for scaffold
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: AppColors.primary,
        ),
    primarySwatch: MaterialColor(0xffD1AB5F, colorCodes),
    dividerColor: AppColors.borderColor,
    canvasColor: Colors.transparent,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
    // canvasColor: Colors.transparent,
    //    colorScheme:
    //     Theme.of(context).colorScheme.copyWith(primary: ColorApp.primary),
    // iconTheme: Theme.of(context).iconTheme.copyWith(size: 12.0),
    // fontFamily: 'Metropolis', //Font family for app

    appBarTheme: AppBarTheme(
      centerTitle: true,
    //Center appbar title
      color: AppColors.white, //Appbar color
    ),
    iconTheme: IconThemeData(
      color: AppColors.primary, //Icon color
    ),

    //Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(), //Button shape
      buttonColor: AppColors.primary, //Button color
      splashColor: AppColors.primary, //Button splash color
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.hintColor),
      fillColor: AppColors.white,//Label style for input fields
      floatingLabelStyle: TextStyle(
          color: AppColors.primary), //Floating label style for input fields
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      contentPadding: const EdgeInsets.all(
          10), //Content padding for input fields
    ),

    //Text theme
    // textTheme: TextTheme(
    //   headline1: , //Headline 1 text style
    //   headline2: , //Headline 2 text style
    //   headline3: , //Headline 3 text style
    //   headline4: , //Headline 4 text style
    //   headline5: , //Headline 5 text style
    //   subtitle1: , //Subtitle 1 text style
    //   subtitle2: , //Subtitle 2 text style
    //   bodyText1: , //Body text 1 text style
    //   bodyText2: , //Body text 2 text style
    // ),
  );
}
