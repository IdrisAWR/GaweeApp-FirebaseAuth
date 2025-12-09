// lib/resume_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart'; 
import 'package:coba_1/features/resume/widgets/upload_resume_sheet.dart';
import 'package:coba_1/features/resume/widgets/create_resume_sheet.dart';

class ResumeScreen extends StatefulWidget {
  const ResumeScreen({Key? key}) : super(key: key);

  @override
  _ResumeScreenState createState() => _ResumeScreenState();
}

class _ResumeScreenState extends State<ResumeScreen> {
  // Key untuk mengontrol Scaffold (agar tombol '...' bisa buka drawer)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(), // Hubungkan drawer
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: titleColor),
          onPressed: () => Navigator.of(context).pop(), // Tombol kembali
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
              _scaffoldKey.currentState?.openDrawer(); // Buka drawer
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Bagian 1: Upload ---
            _buildResumeSection(
              context,
              title: "Post Your Resumes",
              description: "Adding your resume allows you to reply very quickly to many jobs from any device",
              iconWidget: Image.asset(
                'assets/images/upload.png', // <-- Ganti dengan path ikon Anda
                width: 60,
                height: 60,
              ), // Ganti dengan ikon aset jika punya
              sectionTitle: "Upload your resume",
              sectionDescription: "Upload your resume and you'll be able to apply to jobs in just one click!",
              buttonText: "Upload",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, 
                  backgroundColor: Colors.transparent,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const UploadResumeSheet(), // <-- Memanggil sheet upload
                  ),
                );
              },
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Divider(),
            ),

            // --- Bagian 2: Create ---
            _buildResumeSection(
              context,
              title: "Create your resume", // Koreksi tipo dari "Crete"
              description: "Don't have a resume? Create one in no time with our easy-to-use Resume-builder tool",
              iconWidget: Image.asset(
                'assets/images/create.png', // <-- Ganti dengan path ikon Anda
                width: 60,
                height: 60,
              ),// Ganti dengan ikon aset jika punya
              sectionTitle: "Create your resume",
              sectionDescription: "Don't have a resume? Create one in no time with our easy-to-use Resume-builder tool",
              buttonText: "Create",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, 
                  backgroundColor: Colors.transparent,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const CreateResumeSheet(), // <-- Memanggil sheet create
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk membuat satu bagian (Upload/Create)
  Widget _buildResumeSection(
    BuildContext context, {
    required String title,
    required String description,
    required Widget iconWidget,
    required String sectionTitle,
    required String sectionDescription,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Judul besar
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        // Deskripsi di bawah judul
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(color: subtitleColor, fontSize: 15, height: 1.4),
        ),
        const SizedBox(height: 30),
        
        // Ikon
        iconWidget,
        const SizedBox(height: 20),
        
        // Judul bagian (Upload your resume)
        Text(
          sectionTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: titleColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        // Deskripsi bagian
        Text(
          sectionDescription,
          textAlign: TextAlign.center,
          style: TextStyle(color: subtitleColor, fontSize: 15, height: 1.4),
        ),
        const SizedBox(height: 24),
        
        // Tombol
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            buttonText.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}