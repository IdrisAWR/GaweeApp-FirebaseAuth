// lib/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/custom_form_field.dart'; // Impor widget kustom kita

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFFF9F7FF);
    Color primaryColor = const Color(0xFF9634FF);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Logo Gawee di atas
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/gawee.png', // Logo dengan teks
                      width: 200,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 2. Teks "Forget Password"
              const Text(
                "Forget Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),

              // 3. Email Field
              const CustomFormField(
                hintText: "Email Address",
              ),
              const SizedBox(height: 30),

              // 4. Tombol Submit
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika submit email di sini
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(), // Mendorong teks di bawah ke dasar

              // 5. Teks "Login here"
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Kembali ke halaman Login
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                    children: [
                      const TextSpan(text: "Sign in to your registered account\n"),
                      TextSpan(
                        text: "Login here",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}