// lib/upload_resume_sheet.dart
import 'package:flutter/material.dart';

class UploadResumeSheet extends StatelessWidget {
  const UploadResumeSheet({Key? key}) : super(key: key);

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
            'assets/images/upload.png', // Ganti dengan ikon Anda
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 20),

          // Judul
          Text(
            "Upload your resume",
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

          // Upload Resume Area
          DottedBorderContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "+Upload Resume",
                  style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Icon(Icons.add_to_photos_outlined, color: primaryColor, size: 24),
              ],
            ),
            onTap: () {
              // TODO: Logika memilih file
              print("Upload Resume tapped!");
            },
          ),
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

          // Upload Button
          ElevatedButton(
            onPressed: () {
              // TODO: Logika upload resume
              Navigator.pop(context); // Tutup sheet
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Upload",
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

// Widget untuk Dotted Border (perlu dibuat terpisah)
class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const DottedBorderContainer({Key? key, required this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.05), // Latar belakang samar
          border: Border.all(
            color: primaryColor,
            style: BorderStyle.none, // Dotted style
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}