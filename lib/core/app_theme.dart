// lib/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // --- TEMA TERANG (LIGHT MODE) ---
  // --- PERUBAHAN DI SINI ---
  static ThemeData lightTheme(Color primaryColor, Color lightScaffoldColor) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor, // Tetap ungu (konstan)
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      
      // --- PERUBAHAN DI SINI ---
      // Latar belakang sekarang dinamis dari provider
      scaffoldBackgroundColor: lightScaffoldColor, 
      
      // Sisanya konstan
      cardColor: Colors.white,
      hintColor: Colors.grey.shade600,
      
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1F1D2B)),
        bodyMedium: TextStyle(color: Color(0xFF6E6E6E)),
      ),
      appBarTheme: AppBarTheme(
        // AppBar juga harus ganti warna
        backgroundColor: lightScaffoldColor, 
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1F1D2B)),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
      ),
    );
  }

  // --- TEMA GELAP (DARK MODE) ---
  // (File ini tidak berubah, tapi tetap disertakan)
  static ThemeData darkTheme(Color primaryColor) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor, 
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF1F1D2B), 
      cardColor: const Color(0xFF2E2D2B),
      hintColor: Colors.white.withOpacity(0.8),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Color(0xFFAAAAAA)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1D2B),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFF2E2D2B),
      ),
    );
  }
}