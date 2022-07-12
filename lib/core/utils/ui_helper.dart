import 'package:flutter/material.dart';

class UiHelper {
  static const SMALL_FONT = 12.0;
  static const MEDIUM_FONT = 14.0;
  static const LARGE_FONT = 16.0;
  static const X_LARGE_FONT = 18.0;
  static const XX_LARGE_FONT = 25.0;
  static const HEADLINE_SMALL_FONT = 20.0;
  static const HEADLINE_MEDIUM_FONT = 25.0;

  static const WHITE_COLOR = Colors.white;
  static const BLACK_COLOR = Colors.black;
  static const RED_COLOR = Colors.redAccent;
  static const GREEN_COLOR = Color(0xff86C548);
  static const BLUE_COLOR=Colors.blueAccent;
  static const BROWN_COLOR=Colors.brown;
  static const ORANGE_COLOR=Color(0xffffe0b2);

  static const NORMAL_FONT = FontWeight.normal;
  static const BOLD_FONT = FontWeight.bold;

  static const ELEVATION=10.0;
  static const APP_BAR_ICON_SIZE=35.0;

  static ThemeData appTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: WHITE_COLOR,
      textTheme: TextTheme(
        headlineMedium: TextStyle(
            fontSize: HEADLINE_MEDIUM_FONT,
            fontWeight: BOLD_FONT,
            color: WHITE_COLOR),
        headlineSmall: TextStyle(
            fontSize: HEADLINE_SMALL_FONT,
            fontWeight: BOLD_FONT,
            color: WHITE_COLOR),
        bodyLarge: TextStyle(
            fontSize: XX_LARGE_FONT, fontWeight: BOLD_FONT, color: BLACK_COLOR),
        bodyMedium: TextStyle(
            fontSize: LARGE_FONT, fontWeight: NORMAL_FONT, color: BLACK_COLOR),
        bodySmall: TextStyle(
            fontSize: MEDIUM_FONT, fontWeight: NORMAL_FONT, color: BLACK_COLOR),
      ),
      scaffoldBackgroundColor: WHITE_COLOR,
      appBarTheme: AppBarTheme(
        backgroundColor: BLUE_COLOR,
        iconTheme: IconThemeData(color: WHITE_COLOR,
            size: APP_BAR_ICON_SIZE),
        centerTitle: true,
        elevation: ELEVATION,
          titleTextStyle: TextStyle(
              fontSize: HEADLINE_MEDIUM_FONT,
              fontWeight: BOLD_FONT,
              color: WHITE_COLOR),


      ),

    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: GREEN_COLOR,
        content: Text(
          message,
          style: TextStyle(
              fontSize: LARGE_FONT,
              fontWeight: NORMAL_FONT,
              color: WHITE_COLOR),
        )));
  }
}
