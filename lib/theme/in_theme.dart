import 'package:flutter/material.dart';

class InTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,

      primaryColor: Colors.white,
      accentColor: const Color(0xfff70c36), // These are the color of the ISATI
      cardColor: Colors.white,

      appBarTheme: const AppBarTheme(
        // color: Colors.white,
        elevation: 0,
      ),

      // fontFamily: "Futura Light",

      textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.w800,
              color: Colors.black87),
          headline2: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              color: Colors.black87),
          subtitle1: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w800,
              color: Colors.black87)),

      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
