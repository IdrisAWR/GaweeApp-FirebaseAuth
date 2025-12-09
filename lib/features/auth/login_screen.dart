// lib/login_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/custom_form_field.dart';
import 'forgot_password_screen.dart';
import 'create_account_screen.dart';
import 'package:coba_1/features/home/home_screen.dart';
import 'package:coba_1/services/auth_service.dart'; // Import service

class LoginScreen extends StatefulWidget {
  final int initialTabIndex;

  const LoginScreen({Key? key, this.initialTabIndex = 0}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Controller login
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Color primaryColor = const Color(0xFF9634FF);
  Color backgroundColor = const Color(0xFFF9F7FF);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() => _isLoading = true);
    
    // Login menggunakan Service
    String? result = await AuthService().login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
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
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
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
            TabBar(
              controller: _tabController,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: primaryColor,
              indicatorWeight: 3.0,
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: "JOB SEEKER"),
                Tab(text: "COMPANY"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Kita pakai widget yang sama untuk kedua tab karena logikanya sama untuk demo ini
                  _buildLoginForm(context, "Sign in to your registered account"),
                  _buildLoginForm(context, "Company account"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, String title) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 20),
          CustomFormField(
            hintText: "Email / User Name", 
            controller: _emailController, // Pasang controller
          ),
          const SizedBox(height: 20),
          CustomFormField(
            hintText: "Password", 
            obscureText: true,
            controller: _passwordController, // Pasang controller
          ),
          const SizedBox(height: 30),
          
          ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: _isLoading 
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
          ),
          const SizedBox(height: 20),
          
          // ... (Bagian lupa password dan social login tetap sama, diringkas agar tidak kepanjangan)
           GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 15, color: Colors.black54),
                children: [
                  const TextSpan(text: "Forgot your password? "),
                  TextSpan(
                    text: "Reset here",
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: primaryColor, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              "CREATE ACCOUNT",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}