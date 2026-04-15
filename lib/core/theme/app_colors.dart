import 'package:flutter/material.dart';

class AppColors {
  // PRIMARY COLORS
  static final Color primary = HexColor.fromHex('#D1AB5F');
  static final Color lightPrimary = HexColor.fromHex('#00187D');
  static final Color accent = HexColor.fromHex('#DBA926');

  // STATE COLORS
  // static final Color successColor = HexColor.fromHex('#6EBF97');
  static final Color error = HexColor.fromHex('#E01942');

  ///// GREY COLOR
  static final Color hintColor = white.withOpacity(.5);
  static final Color darkGrayColor = HexColor.fromHex('#2D2D2D');
  static final Color grayColor = HexColor.fromHex('#6F6F6F');
  static final Color textColor = HexColor.fromHex('#939393');
  static final Color titleColor = HexColor.fromHex('#B0B0B0');
  static final Color borderColor = HexColor.fromHex('#7D7E84');
  static final Color lightBlack = HexColor.fromHex('#2D2D2D');
  static final Color background = HexColor.fromHex('#252525');
  static final Color darkBackground = HexColor.fromHex('#1D1D1D');
  static final Color scaffoldBackground = HexColor.fromHex('#222222');

  //// OTHER
  static final Color black = HexColor.fromHex('#000000');
  static final Color brown = HexColor.fromHex('#C35858');
  static final Color white = HexColor.fromHex('#FFFFFF');
  static final Color red = HexColor.fromHex('#E03131');
  static final Color yellow = HexColor.fromHex('#FDB302');
  static final Color lightYellow = HexColor.fromHex('#FDB3020F');
  static final Color blue = HexColor.fromHex('#2385AF');
  static final Color face = HexColor.fromHex('#2B5EB7');
  static final Color green = HexColor.fromHex('#23AF64');

}

//Extension for converting hex color string to color
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    //Adding FF to the beginning of the string
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

Map<int, Color> colorCodes = {
  50: Color.fromRGBO(209, 171, 95, .1),
  100: Color.fromRGBO(209, 171, 95, .2),
  200: Color.fromRGBO(209, 171, 95, .3),
  300: Color.fromRGBO(209, 171, 95, .4),
  400: Color.fromRGBO(209, 171, 95, .5),
  500: Color.fromRGBO(209, 171, 95, .6),
  600: Color.fromRGBO(209, 171, 95, .7),
  700: Color.fromRGBO(209, 171, 95, .8),
  800: Color.fromRGBO(209, 171, 95, .9),
  900: Color.fromRGBO(209, 171, 95, 1),
};
