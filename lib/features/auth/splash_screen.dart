import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // <--- 1. IMPORT PAKET INI
import 'onboarding_screen.dart'; // Pastikan ini mengarah ke file Tahap 2 Anda

class SplashScreen extends StatefulWidget {
  // Gunakan super.key (saran perbaikan dari gambar Anda sebelumnya)
  const SplashScreen({super.key}); 

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  startSplashScreenTimer() async {
    var duration = const Duration(seconds: 3); // Durasi tetap 3 detik
    
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(), // Arahkan ke Onboarding
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromRGBO(131, 76, 224, 1); // Warna ungu

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 1. Logo Anda
            Image.asset(
              'assets/images/logo_gawee.png', // Pastikan nama file ini SAMA
              width: 150,
            ),
            
            const SizedBox(height: 20),
            
            const SizedBox(height: 5),

            // 3. GANTI Teks "..." statis DENGAN INI:
            const SpinKitThreeBounce(
              color: Colors.white, // Warna titik-titiknya
              size: 25.0,
               // Jarak animasi dari 0.0 sampai 1.0
              duration: Duration(seconds: 2),
            ),
          ],
        ),
      ),
    );
  }
}