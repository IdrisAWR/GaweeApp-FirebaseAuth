// lib/resume_language_sheet.dart
import 'package:flutter/material.dart';

class ResumeLanguageSheet extends StatefulWidget {
  final String initialLanguage; // Untuk menampilkan bahasa saat ini
  final Function(String) onSave; // Callback saat bahasa disimpan

  const ResumeLanguageSheet({
    Key? key,
    required this.initialLanguage,
    required this.onSave,
  }) : super(key: key);

  @override
  _ResumeLanguageSheetState createState() => _ResumeLanguageSheetState();
}

class _ResumeLanguageSheetState extends State<ResumeLanguageSheet> {
  String? _selectedLanguage; // Bahasa yang dipilih di dropdown

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.initialLanguage; // Set bahasa awal
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    // Daftar bahasa dummy
    final List<String> languages = [
      "English",
      "Indonesian",
      "Arabic",
      "Mandarin",
      "Spanish",
      "French",
      "German",
      "Japanese",
      "Russian",
      "Portuguese",
      "Italian",
      "Korean",
    ];

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar column tidak memakan seluruh tinggi
        children: [
          // --- Ikon dan Judul ---
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.article, // Ikon resume/dokumen
              color: primaryColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Resume Language",
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          // --- Input Dropdown Bahasa ---
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Resume Language",
              style: TextStyle(
                color: subtitleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedLanguage,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: subtitleColor),
                style: TextStyle(color: titleColor, fontSize: 16),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                },
                items: languages.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 30),

          // --- Tombol Save ---
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedLanguage != null
                  ? () {
                      widget.onSave(_selectedLanguage!); // Panggil callback dengan bahasa terpilih
                      Navigator.pop(context); // Tutup sheet
                    }
                  : null, // Nonaktifkan jika belum ada pilihan
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // --- Tombol Cancel ---
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup sheet tanpa menyimpan
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor, // Warna teks
                side: BorderSide(color: primaryColor, width: 2), // Warna border
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}