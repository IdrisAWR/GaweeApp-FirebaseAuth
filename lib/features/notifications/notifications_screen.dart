// lib/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart'; // Impor AppDrawer Anda

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Key untuk mengontrol Scaffold (agar tombol '...' bisa buka drawer)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Data dummy untuk daftar notifikasi
  final List<Map<String, dynamic>> notifications = [
    {
      "type": "apply_success",
      "title": "Apply Success",
      "description": "You has apply an job in Queenify Group as UI Designer",
      "time": "10h ago",
      "color": Colors.teal, // Ganti warna sesuai tipe
    },
    {
      "type": "interview",
      "title": "Interview Calls",
      "description": "Congratulations! You have interview calls",
      "time": "9h ago",
      "color": Colors.grey, // Ganti warna sesuai tipe
    },
    {
      "type": "apply_success",
      "title": "Apply Success",
      "description": "You has apply an job in Queenify Group as UI Designer",
      "time": "8h ago",
      "color": Colors.purple, // Ganti warna sesuai tipe
    },
    {
      "type": "profile",
      "title": "Complete your profile",
      "description": "Please verify your profile information to continue using this app",
      "time": "4h ago",
      "color": Colors.teal, // Ganti warna sesuai tipe
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          "Notifications",
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
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return _buildNotificationCard(
            context,
            notif['title']!,
            notif['description']!,
            notif['time']!,
            notif['color'] as Color, // Kirim warna
          );
        },
      ),
    );
  }

  // Widget helper untuk satu kartu notifikasi
  Widget _buildNotificationCard(
    BuildContext context,
    String title,
    String description,
    String time,
    Color circleColor,
  ) {
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;
    final Color primaryColor = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris atas: Lingkaran dan Judul
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: circleColor, // Warna dari data
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Deskripsi (dengan padding kiri agar sejajar teks)
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text(
              description,
              style: TextStyle(color: subtitleColor, fontSize: 14, height: 1.4),
            ),
          ),
          const SizedBox(height: 12),

          // Baris bawah: Waktu dan "Mark as read"
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(color: subtitleColor, fontSize: 13),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: Tambahkan logika "Mark as read"
                  },
                  child: Text(
                    "Mark as read",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}