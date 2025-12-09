// lib/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // Ambil user saat ini
  final User? user = FirebaseAuth.instance.currentUser;

  // --- INTEGRASI FIREBASE: Fungsi Update Bio/Job ---
  void _showEditBioDialog(BuildContext context, String currentBio, String currentJob) {
    final bioController = TextEditingController(text: currentBio);
    final jobController = TextEditingController(text: currentJob);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: jobController,
              decoration: const InputDecoration(labelText: "Job Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(labelText: "Bio"),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Cancel")
          ),
          ElevatedButton(
            onPressed: () async {
              // Simpan ke Firestore
              if (user != null) {
                await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                  'bio': bioController.text,
                  'job_title': jobController.text,
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

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
          "Profile",
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
      // --- INTEGRASI FIREBASE: StreamBuilder untuk membaca data Profil ---
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
        builder: (context, snapshot) {
          // 1. Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Data State
          String name = "User";
          String jobTitle = "Job Seeker";
          String bio = "No bio available";

          if (snapshot.hasData && snapshot.data!.exists) {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            name = userData['username'] ?? "User";
            jobTitle = userData['job_title'] ?? "Job Seeker";
            bio = userData['bio'] ?? "No bio available";
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/3.jpg'), 
                ),
                const SizedBox(height: 15),

                // Nama & Job Title (Dinamis dari Firebase)
                Text(
                  name,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  jobTitle,
                  style: TextStyle(color: subtitleColor, fontSize: 16),
                ),
                
                // Tombol Edit (Fitur CRUD: Update)
                IconButton(
                  icon: Icon(Icons.edit, color: primaryColor),
                  tooltip: "Edit Profile",
                  onPressed: () => _showEditBioDialog(context, bio, jobTitle),
                ),

                const SizedBox(height: 10),

                // Bio (Dinamis dari Firebase)
                Text(
                  bio,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: subtitleColor, fontSize: 15, height: 1.5),
                ),
                const SizedBox(height: 30),

                _buildResumeButton(context, primaryColor),
                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Skills",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                _buildSkillBar(context, "Problem Solving", 70),
                _buildSkillBar(context, "Drawing", 35),
                _buildSkillBar(context, "Illustration", 80),
                _buildSkillBar(context, "Photoshop", 34),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResumeButton(BuildContext context, Color primaryColor) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Resume",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text(
                  "david_resume.pdf",
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                ),
              ],
            ),
            const Icon(Icons.file_upload_outlined, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillBar(BuildContext context, String skillName, int percentage) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skillName,
                style: TextStyle(color: titleColor, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "$percentage%",
                style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100.0,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}