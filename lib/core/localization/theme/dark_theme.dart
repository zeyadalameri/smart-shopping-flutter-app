import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get(String fontFamily) {
    return ThemeData(
      fontFamily: fontFamily,
      useMaterial3: false,

      primaryColor: const Color(0xFF0088CC),

      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF0088CC),
        onPrimary: Colors.white,
        secondary: Color(0xFFEAE8E8),
        onSecondary: Color(0xFF787676),
        surface: Color(0xFF232F3E),
        onSurface: Color(0xFFD9D9D9),
        error: Color(0xFFCF6679),
        onError: Colors.black,
      ),

      scaffoldBackgroundColor: const Color(0xFF1C2733),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF232F3E),
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0088CC),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF0088CC),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF0088CC),
          side: const BorderSide(color: Color(0xFF0088CC), width: 1.5),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, height: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF0088CC),
        foregroundColor: Colors.white,
        elevation: 3,
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: const Color(0xFF232F3E),
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogTheme(
        backgroundColor: const Color(0xFF232F3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Input Decoration (TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF232F3E),
        hintStyle: TextStyle(color: Colors.grey[400]),
        labelStyle: const TextStyle(color: Color(0xFF0088CC)),
        floatingLabelStyle: const TextStyle(color: Color(0xFF0088CC)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: const Color(0xFF0088CC), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFCF6679), width: 2),
        ),
      ),

      // Text Theme (Fixed spacing issues)
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Color(0xFFD9D9D9)),
        displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Color(0xFFD9D9D9)),
        displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Color(0xFFD9D9D9)),
        headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: Color(0xFFD9D9D9)),
        bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            height: 1.2,
            color: Color(0xFFD9D9D9)),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            height: 1.2,
            color: Color(0xFFBDBDBD)),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: Color(0xFF0088CC)),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            height: 1.2,
            color: Color(0xFFA6A6A6)),
      ),
    );
  }
}
