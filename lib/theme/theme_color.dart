import 'package:flutter/material.dart';

class AppThemes {
  static final pinkTheme = ThemeData(
    primaryColor: const Color(0xFFE16472),
    focusColor:  Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFE16472),
      secondary: Color(0xFFD44D5C),
    ),
  );

  static final blueTheme = ThemeData(
    primaryColor: Colors.blue,
    focusColor:  Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade200,
      secondary: Colors.lightBlueAccent,
    ),
  );

  static final greenTheme = ThemeData(
    primaryColor: Colors.green,
    focusColor:  Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF429690),
      secondary: Color(0xFF2A7C76),
    ),
  );

  static final orangeTheme = ThemeData(
    primaryColor: Colors.orange,
    focusColor:  Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.orange.shade200,
      secondary: Colors.deepOrangeAccent,
    ),
  );

  static final darkTheme = ThemeData(
    hintColor: Colors.white,

    primaryColor: const Color(0xFF000000),
    focusColor:  Color(0xFFE16472),
    scaffoldBackgroundColor: const Color(0xFF221F1F),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF000000),
      secondary: Color(0xFF343030),
    ),
  );

  static final themes = {
    'Pink': pinkTheme,
    'Blue': blueTheme,
    'Green': greenTheme,
    'Orange': orangeTheme,
    'Dark': darkTheme,
  };
}
