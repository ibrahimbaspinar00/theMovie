import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xfff5f7fb),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff6C63FF),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      centerTitle: true,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff121212),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff6C63FF),
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff1e1e1e),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
  );
}