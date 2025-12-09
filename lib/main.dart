// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coba_1/features/auth/splash_screen.dart';
import 'package:coba_1/core/theme_provider.dart';
import 'package:coba_1/core/app_theme.dart';
import 'firebase_options.dart'; // Pastikan file ini ada (hasil flutterfire configure)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase dengan opsi platform (penting agar tidak error di Android/iOS)
  // Jika file firebase_options.dart belum ada, jalankan 'flutterfire configure' dulu.
  // Jika belum bisa configure, pakai await Firebase.initializeApp(); saja dulu.
  await Firebase.initializeApp(); 

  runApp(
    // --- PERBAIKAN DI SINI: Bungkus Root dengan MultiProvider ---
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sekarang Consumer bisa menemukan ThemeProvider karena sudah dibungkus di atas
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Gawee App',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme(
            themeProvider.primaryColor,
            themeProvider.lightScaffoldColor,
          ),
          darkTheme: AppTheme.darkTheme(
            themeProvider.primaryColor,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

