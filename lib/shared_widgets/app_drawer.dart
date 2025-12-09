// lib/shared_widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba_1/services/auth_service.dart';

// Import halaman-halaman (Pastikan path-nya sesuai project Anda)
import 'package:coba_1/features/home/home_screen.dart';
import 'package:coba_1/features/job/recent_job_screen.dart';
import 'package:coba_1/features/auth/pilih_peran_screen.dart'; 
import 'package:coba_1/features/job/find_job_screen.dart';
import 'package:coba_1/features/notifications/notifications_screen.dart';
import 'package:coba_1/features/profile/profile_screen.dart';
import 'package:coba_1/features/messages/messages_screen.dart';
import 'package:coba_1/features/settings/elements_screen.dart';
import 'package:coba_1/features/settings/setting_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ambil user yang sedang login
    final User? user = FirebaseAuth.instance.currentUser;
    
    // Warna tema
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;
    final Color backgroundColor = Theme.of(context).drawerTheme.backgroundColor ?? Theme.of(context).cardColor;

    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          // --- HEADER DINAMIS (Menampilkan Data User) ---
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
            builder: (context, snapshot) {
              // Data default jika loading / error
              String displayName = "Gawee User";
              String email = user?.email ?? "No Email";
              String role = "Job Seeker";

              if (snapshot.hasData && snapshot.data!.exists) {
                var data = snapshot.data!.data() as Map<String, dynamic>;
                displayName = data['username'] ?? "Gawee User";
                // email = data['email'] ?? email; // Bisa ambil dari firestore atau auth
                role = data['role'] ?? "Job Seeker";
              }

              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: backgroundColor, // Sesuaikan dengan tema (putih/gelap)
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: primaryColor,
                  backgroundImage: const AssetImage('assets/images/user1.jpg'), // Foto default
                  // Jika ingin pakai inisial:
                  // child: Text(displayName[0].toUpperCase(), style: const TextStyle(color: Colors.white)),
                ),
                accountName: Text(
                  displayName,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      email,
                      style: TextStyle(color: subtitleColor),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        role,
                        style: TextStyle(color: primaryColor, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                // Tombol Close di pojok kanan atas
                otherAccountsPictures: [
                  IconButton(
                    icon: Icon(Icons.close, color: titleColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          ),

          // --- LIST MENU ---
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.home_rounded,
                  text: 'Home',
                  color: primaryColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.history_rounded,
                  text: 'Recent Job',
                  color: subtitleColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RecentJobScreen()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.search_rounded,
                  text: 'Find Job',
                  color: subtitleColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FindJobScreen()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.notifications_rounded,
                  text: 'Notifications',
                  color: subtitleColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.person_rounded,
                  text: 'Profile',
                  color: subtitleColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.message_rounded,
                  text: 'Message',
                  color: subtitleColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesScreen()));
                  },
                ),
                const Divider(), // Garis pemisah
                _buildDrawerItem(
                  icon: Icons.settings_rounded,
                  text: 'Setting',
                  color: subtitleColor,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingScreen()));
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.logout_rounded,
                  text: 'Logout',
                  color: Colors.redAccent, // Warna merah untuk logout
                  onTap: () async {
                    // LOGOUT FIREBASE
                    await AuthService().logout();

                    // Kembali ke halaman awal & hapus semua history navigasi
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const PilihPeranScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          
          // --- FOOTER ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'App Version 1.3',
              style: TextStyle(color: subtitleColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color, size: 24),
      title: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true, // Membuat item lebih rapat/rapi
      visualDensity: VisualDensity.compact,
    );
  }
}