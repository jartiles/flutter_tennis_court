import 'package:flutter/material.dart';

class CustomTheme {
  static Color primaryColor = const Color(0xFF32a060);

  static final Decoration cardStyle = BoxDecoration(
    gradient: const LinearGradient(
      colors: [
        Color(0xFF1e1e28),
        Color(0xFF211539),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.3, 0.8],
    ),
    borderRadius: BorderRadius.circular(10),
  );

  static ThemeData customTheme = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: const StadiumBorder(),
      ),
    ),
  );
}
