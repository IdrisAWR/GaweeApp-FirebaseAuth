// lib/create_account_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/custom_form_field.dart';
import 'forgot_password_screen.dart';
import 'package:coba_1/features/home/home_screen.dart';
import 'package:coba_1/services/auth_service.dart'; // Import service

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  // Controller untuk input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon isi semua data")),
      );
      return;
    }

    setState(() => _isLoading = true);

    String? result = await AuthService().register(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      username: _usernameController.text.trim(),
      role: 'Job Seeker',
    );

    setState(() => _isLoading = false);

    if (result == null) {
      // Sukses
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Gagal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFFF9F7FF);
    Color primaryColor = const Color(0xFF9634FF);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/gawee.png', width: 200),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Form Fields dengan Controller
                CustomFormField(
                  hintText: "Email Address",
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  hintText: "User Name",
                  controller: _usernameController,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 30),

                // Tombol Submit
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "SUBMIT",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 20),

                // Footer links (sama seperti sebelumnya)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 15, color: Colors.black54),
                      children: [
                        const TextSpan(text: "Forgot your password? "),
                        TextSpan(
                          text: "Reset here",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: Text(
                    "Already have an account",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: primaryColor, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}