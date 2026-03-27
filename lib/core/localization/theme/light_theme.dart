import 'package:flutter/material.dart';
import 'package:smart_shopping_fe/core/localization/theme/color_app.dart';

class LightTheme {
  static ThemeData get(String fontFamily) {
    return ThemeData(
      fontFamily: fontFamily,
      useMaterial3: true,

      primaryColor: AppColors.kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,

      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF2B9086), // Turquoise
        onPrimary: Colors.white,
        secondary: Color(0xFF008080), // Deeper teal
        onSecondary: Color(0xFFEBEAEA),
        error: Color(0xFFD32F2F),
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Color(0xFF202124),
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFF008080),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          height: 1.2, // Fixed text height
        ),
        iconTheme: IconThemeData(color: Color(0xFF008080)),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.2, // Fixed spacing
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.kPrimaryColor,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.kPrimaryColor,
          side: const BorderSide(color: AppColors.kPrimaryColor, width: 1.5),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, height: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF008080),
        foregroundColor: Colors.white,
        elevation: 3,
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Input Decoration (TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: Colors.grey[600]),
        labelStyle: const TextStyle(color: AppColors.kPrimaryColor),
        floatingLabelStyle: const TextStyle(color: AppColors.kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
        ),
      ),

      // Text Theme (Fixed spacing issues)
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Color(0xFF202124)),
        displayMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Color(0xFF202124)),
        displaySmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.2,
            color: Color(0xFF202124)),
        headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: Color(0xFF202124)),
        bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            height: 1.2,
            color: Color(0xFF202124)),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            height: 1.2,
            color: Color(0xFF5F6368)),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: AppColors.kPrimaryColor),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            height: 1.2,
            color: Color(0xFF5F6368)),
      ),
    );
  }
}
