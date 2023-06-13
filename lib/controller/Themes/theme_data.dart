import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Themes extends GetxController{
  static ThemeData thetheme = custumLight;


  static ThemeData custumDark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    // textTheme: TextTheme(
    //   headlineLarge: TextStyle(color: Colors.red),
    //   headlineMedium: TextStyle(color: Colors.red),
    //   headlineSmall: TextStyle(color: Colors.red),
    //   bodyLarge: TextStyle(color: Colors.red),
    //   bodyMedium: TextStyle(color: Colors.red),
    //   bodySmall: TextStyle(color: Colors.red),
    // )
  );

  static ThemeData custumLight = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0
    ),
    scaffoldBackgroundColor: Colors.white,
  );
  
}