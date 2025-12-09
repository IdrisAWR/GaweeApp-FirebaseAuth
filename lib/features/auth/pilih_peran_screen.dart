// lib/pilih_peran_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';

class PilihPeranScreen extends StatelessWidget {
  const PilihPeranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFFF9F7FF);
    Color jobSeekerColor = const Color(0xFF9634FF);
    Color companyColor = const Color(0xFF569AFF);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // HAPUS: 'mainAxisAlignment: MainAxisAlignment.center'
            crossAxisAlignment: CrossAxisAlignment.stretch, // Tetap
            children: [
              // 1. Logo Icon
              // Kita tambahkan sedikit padding di atas agar tidak terlalu mepet
              const SizedBox(height: 40), 
              Image.asset(
                'assets/images/logoo.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 300),

              // 2. Teks "Who are you?"
              const Text(
                "Who are you?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              // 3. Teks "Lorem ipsum..."
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed do eiusmod tempor",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              // --- INI PERUBAHAN UTAMA ---
              // Ganti SizedBox(height: 50) dengan Spacer()
              const Spacer(), // Widget ini akan mendorong tombol ke bawah

              // 4. Tombol Job Seekers
              RoleSelectionButton(
                title: "JOB SEEKERS",
                subtitle: "Finding a job here never \nbeen easier than before",
                buttonColor: jobSeekerColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(initialTabIndex: 0),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // 5. Tombol Company
              RoleSelectionButton(
                title: "COMPANY",
                subtitle: "Let's recruit your great \ncandidate faster here",
                buttonColor: companyColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(initialTabIndex: 1),
                    ),
                  );
                },
              ),
              
              // Tambahkan sedikit jarak di bawah agar tombol tidak mepet
              const SizedBox(height: 30), 
            ],
          ),
        ),
      ),
    );
  }
}

// Widget RoleSelectionButton (TIDAK BERUBAH)
class RoleSelectionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color buttonColor;
  final VoidCallback onTap;

  const RoleSelectionButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.buttonColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: buttonColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}