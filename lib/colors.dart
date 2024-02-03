import 'package:flutter/material.dart';

class AppColor {
  static Color homePageBackground = Colors.yellow;
  static Color pageBackground = Colors.yellow;
  static Color gradientFirst = const Color.fromARGB(255, 255, 230, 0);
  static Color gradientSecond = const Color.fromARGB(255, 255, 196, 0);
  static Color primaryColor = const Color.fromARGB(255, 255, 196, 0);
  static Gradient customGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 230, 0),
      Color.fromARGB(255, 255, 196, 0),
    ],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
}
