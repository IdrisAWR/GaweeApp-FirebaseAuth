// lib/messages_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart'; // Impor AppDrawer Anda
import 'message_detail_screen.dart'; // Impor halaman detail

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // Key untuk mengontrol Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Data dummy untuk daftar pesan
  final List<Map<String, dynamic>> messages = [
    {
      "image": "assets/images/1.jpg", // Ganti dengan aset Anda
      "name": "Sam Verdinand",
      "message": "OK. Lorem ipsum dolor sect...",
      "time": "2m ago",
      "status": "Read",
    },
    {
      "image": "assets/images/2.jpg", // Ganti dengan aset Anda
      "name": "Freddie Ronan",
      "message": "Roger that sir, thankyou",
      "time": "2m ago",
      "status": "Pending",
    },
    {
      "image": "assets/images/3.jpg", // Ganti dengan aset Anda
      "name": "Ethan Jacoby",
      "message": "Lorem ipsum dolor",
      "time": "2m ago",
      "status": "Read",
    },
    {
      "image": "assets/images/4.jpg", // Ganti dengan aset Anda
      "name": "Alfie Mason",
      "message": "Lorem ipsum dolor sect...",
      "time": "2m ago",
      "status": "Pending",
    },
    {
      "image": "assets/images/5.jpg", // Ganti dengan aset Anda
      "name": "Archie Parker",
      "message": "OK. Lorem ipsum dolor sect...",
      "time": "2m ago",
      "status": "Read",
    },
    {
      "image": "assets/images/6.jpg", // Ganti dengan aset Anda
      "name": "Sam Verdinand",
      "message": "OK. Lorem ipsum dolor sect...",
      "time": "2m ago",
      "status": "Read",
    },
    {
      "image": "assets/images/6.jpg", // Ganti dengan aset Anda
      "name": "Isaac Banford",
      "message": "Roger that sir, thankyou",
      "time": "2m ago",
      "status": "Pending",
    },
    {
      "image": "assets/images/7.jpg", // Ganti dengan aset Anda
      "name": "Henry Hunter",
      "message": "Lorem ipsum dolor",
      "time": "2m ago",
      "status": "Read",
    },
    {
      "image": "assets/images/8.jpg", // Ganti dengan aset Anda
      "name": "Harry Parker",
      "message": "Lorem ipsum dolor sect...",
      "time": "2m ago",
      "status": "Pending",
    },
    {
      "image": "assets/images/5.jpg", // Ganti dengan aset Anda
      "name": "George Carson",
      "message": "OK. Lorem ipsum dolor sect...",
      "time": "2m ago",
      "status": "Read",
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
          "Messages",
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
      body: Column(
        children: [
          // --- Search Bar ---
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              child: TextField(
                style: TextStyle(color: titleColor),
                decoration: InputDecoration(
                  hintText: "Search job here...",
                  hintStyle: TextStyle(color: subtitleColor.withOpacity(0.7)),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: subtitleColor.withOpacity(0.7)),
                ),
              ),
            ),
          ),
          
          // --- Message List ---
          Expanded(
            child: ListView.separated(
              itemCount: messages.length,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              itemBuilder: (context, index) {
                final msg = messages[index];
                return _buildMessageTile(
                  context,
                  msg['image']!,
                  msg['name']!,
                  msg['message']!,
                  msg['time']!,
                  msg['status']!,
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.transparent, // Tidak ada garis, hanya jarak
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk satu item pesan
  Widget _buildMessageTile(
    BuildContext context,
    String imageUrl,
    String name,
    String message,
    String time,
    String status,
  ) {
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final bool isRead = status == "Read";

    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail, mengirim nama pengguna
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageDetailScreen(userName: name),
          ),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(imageUrl),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: TextStyle(color: subtitleColor, fontSize: 14),
                  overflow: TextOverflow.ellipsis, // Jika teks terlalu panjang
                ),
                const SizedBox(height: 5),
                Text(
                  time,
                  style: TextStyle(color: subtitleColor, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Status (Read/Pending)
          Row(
            children: [
              Text(
                status,
                style: TextStyle(
                  color: isRead ? primaryColor : subtitleColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 3),
              Icon(
                Icons.check,
                color: isRead ? primaryColor : subtitleColor,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}