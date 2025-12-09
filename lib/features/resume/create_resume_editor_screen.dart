// lib/create_resume_editor_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart';
import 'package:coba_1/features/resume/widgets/resume_language_sheet.dart';

class CreateResumeEditorScreen extends StatefulWidget {
  const CreateResumeEditorScreen({Key? key}) : super(key: key);

  @override
  _CreateResumeEditorScreenState createState() => _CreateResumeEditorScreenState();
}

class _CreateResumeEditorScreenState extends State<CreateResumeEditorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentLanguage = "English";

  final List<Map<String, dynamic>> _resumeItems = [
    {"icon": Icons.assignment_turned_in, "text": "Personal statement"},
    {"icon": Icons.work, "text": "Employment history"},
    {"icon": Icons.school, "text": "Education"},
    {"icon": Icons.star, "text": "Skills"},
    {"icon": Icons.language, "text": "Language"},
    {"icon": Icons.verified_user, "text": "Certifications"},
    {"icon": Icons.emoji_events, "text": "Awards"},
    {"icon": Icons.link, "text": "Links"},
    {"icon": Icons.volunteer_activism, "text": "Volunteering"},
    {"icon": Icons.interests, "text": "Interests"},
    {"icon": Icons.thumb_up, "text": "References"},
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: titleColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Resume",
          style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: subtitleColor),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Ini tetap start untuk judul "Create your resume"
          children: [
            // --- "Create your resume" Title ---
            Text(
              "Create your resume",
              style: TextStyle(
                color: titleColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // --- User Profile Card ---
            // --- PERUBAHAN DI SINI: Gunakan Center untuk menengahkan container ---
            Center( // <-- TAMBAHKAN WIDGET CENTER INI
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9, // Memberi lebar agar Center bekerja
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  // --- PERUBAHAN DI SINI: Column di dalam Container agar rata tengah ---
                  crossAxisAlignment: CrossAxisAlignment.center, // <-- TAMBAHKAN INI
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/1.jpg'), // Contoh gambar profil
                          backgroundColor: Colors.grey,
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Tushar w3itexperts",
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Web Designer",
                      style: TextStyle(color: subtitleColor, fontSize: 14),
                    ),
                    Text(
                      "Kota, Rajasthan",
                      style: TextStyle(color: subtitleColor, fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "info@example.com",
                      style: TextStyle(color: primaryColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            // --- BATAS PERUBAHAN ---
            const SizedBox(height: 30),

            // --- Resume Language ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Resume Language",
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: primaryColor, size: 20),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: ResumeLanguageSheet(
                          initialLanguage: _currentLanguage, // Kirim bahasa saat ini
                          onSave: (newLanguage) {
                            setState(() {
                              _currentLanguage = newLanguage; // Perbarui bahasa saat disimpan
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _currentLanguage,
              style: TextStyle(color: subtitleColor, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // --- Resume Item List ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _resumeItems.length,
              itemBuilder: (context, index) {
                final item = _resumeItems[index];
                return _buildResumeListItem(
                  icon: item['icon'],
                  text: item['text'],
                  onTap: () {
                    print("Tapped on ${item['text']}");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // (Widget _buildResumeListItem tetap sama)
  Widget _buildResumeListItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).hintColor.withOpacity(0.6),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}