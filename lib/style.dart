import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextStyle placeholderTextFieldStyle =
    TextStyle(color: Colors.grey.shade400);

final appTheme = ThemeData(
  appBarTheme: AppBarTheme(
      color: const Color.fromARGB(255, 0, 0, 0),
      elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 26.0, fontFamily: GoogleFonts.rubik().fontFamily)),
  brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 0, 0, 0),
  fontFamily: GoogleFonts.outfit().fontFamily,
  textTheme: TextTheme(
      displayLarge: const TextStyle(fontSize: 36.0),
      displayMedium: const TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: const TextStyle(
          fontSize: 26.0, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      bodySmall: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade400)),
);
