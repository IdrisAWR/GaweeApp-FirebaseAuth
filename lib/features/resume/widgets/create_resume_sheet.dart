// lib/create_resume_sheet.dart
import 'package:flutter/material.dart';
import 'package:coba_1/features/resume/create_resume_editor_screen.dart';

class CreateResumeSheet extends StatelessWidget {
  const CreateResumeSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar tingginya pas dengan konten
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Icon
          Image.asset(
            'assets/images/create.png', // Ganti dengan ikon Anda
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 20),

          // Judul
          Text(
            "Create your resume", // Dari gambar, ini judulnya sama
            textAlign: TextAlign.center,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // Deskripsi
          Text(
            "Adding your resume allows you to apply very quickly to many jobs from any device",
            textAlign: TextAlign.center,
            style: TextStyle(color: subtitleColor, fontSize: 15, height: 1.4),
          ),
          const SizedBox(height: 30),

          // Email
          Text(
            "Email *",
            style: TextStyle(color: titleColor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildTextField("Type in your email", titleColor, subtitleColor),
          const SizedBox(height: 20),

          // Your job title or qualification
          Text(
            "Your job title or qualification *",
            style: TextStyle(color: titleColor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildTextField("Your job title or qualification", titleColor, subtitleColor),
          const SizedBox(height: 20),

          // Your location
          Text(
            "Your location *",
            style: TextStyle(color: titleColor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildTextField("Town, county or country", titleColor, subtitleColor),
          const SizedBox(height: 30),

          // Create Button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Tutup sheet terlebih dahulu
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateResumeEditorScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Create",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Cancel Button
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context); // Tutup sheet
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: subtitleColor,
              ),
            ),
          ),
          // Padding bawah agar tidak terhalang gesture bar iOS/Android
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, Color textColor, Color hintColor) {
    return TextField(
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintColor.withOpacity(0.7)),
        filled: true,
        fillColor: Colors.grey.shade100, // Warna background field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // Tanpa border
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}