// lib/theme_provider.dart
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // --- KONSTAN ---
  final Color _primaryColor = const Color(0xFF9634FF); // Ungu

  // --- DINAMIS ---
  ThemeMode _themeMode = ThemeMode.light;
  Color _lightScaffoldColor = const Color(0xFFF9F7FF); // Default lavender
  
  // --- BARU: Menyimpan warna palet yang dipilih ---
  Color _selectedPaletteColor = const Color(0xFF9634FF); // Default ke ungu

  // --- GETTER ---
  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;
  Color get lightScaffoldColor => _lightScaffoldColor;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  // --- GETTER BARU ---
  Color get selectedPaletteColor => _selectedPaletteColor;

  // --- SETTER ---
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); 
  }

  void setLightBackgroundFromPal(Color colorFromPallete) {
    // 1. Simpan warna palet yang dipilih
    _selectedPaletteColor = colorFromPallete; 
    
    // 2. Terapkan tint ke background
    _lightScaffoldColor = Color.lerp(Colors.white, colorFromPallete, 0.1)!; 
    
    if (colorFromPallete == Colors.purple) {
      _lightScaffoldColor = const Color(0xFFF9F7FF);
    }
    
    notifyListeners();
  }
}