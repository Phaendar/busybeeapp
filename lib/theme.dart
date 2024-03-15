import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart' as customcolor;

var appTheme = ThemeData(
  //scaffoldBackgroundColor: customcolor.AppColor.homePageBackground,
  scaffoldBackgroundColor: const Color.fromRGBO(228, 217, 189, 1.0),
  fontFamily: GoogleFonts.nunito().fontFamily,
  primaryColor: Colors.black,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color.fromRGBO(228, 217, 189, 1.0),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
    labelLarge: TextStyle(
      color: Colors.black,
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: customcolor.AppColor.gradientSecond,
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  drawerTheme:
      DrawerThemeData(backgroundColor: customcolor.AppColor.homePageBackground),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(customcolor.AppColor.gradientSecond),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
);
