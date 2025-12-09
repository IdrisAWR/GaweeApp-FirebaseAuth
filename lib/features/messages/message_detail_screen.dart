// lib/message_detail_screen.dart
import 'package:flutter/material.dart';

class MessageDetailScreen extends StatefulWidget {
  const MessageDetailScreen({Key? key, required this.userName}) : super(key: key);

  final String userName;

  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  // Data dummy untuk chat
  final List<Map<String, dynamic>> _chatMessages = [
    {"sender": "Me", "text": "Hi, kate", "type": "text"},
    {"sender": "Me", "text": "How are you?", "type": "text"},
    {"sender": "Kate", "text": "Hi, I am good!", "type": "text"},
    {"sender": "Blue Ninja", "text": "Hi there, I am also fine, thanks! And how are you?", "type": "text"},
    {"sender": "Me", "text": "Hey, Blue Ninja! Glad to see you ;)", "type": "text"},
    {"sender": "Me", "text": "Hey, look, cutest kitten ever!", "type": "text"},
    {"sender": "Me", "image": "assets/images/cats.jpg", "type": "image"}, // Ganti dengan URL gambar kucing
    {"sender": "Kate", "text": "Nice!", "type": "text"},
    {"sender": "Kate", "text": "Like it very much!", "type": "text"},
    {"sender": "Blue Ninja", "text": "Awesome!", "type": "text"},
  ];
  
  // Avatar dummy
  final String kateAvatar = "assets/images/9.jpg"; 
  final String ninjaAvatar = "assets/images/a7.jpg"; 

  @override
  Widget build(BuildContext context) {
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: titleColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.userName, // Gunakan nama dari halaman sebelumnya
          style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: Column(
        children: [
          // --- Bagian Chat ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              reverse: false, // Tampilkan dari atas ke bawah
              itemCount: _chatMessages.length + 1, // +1 untuk timestamp
              itemBuilder: (context, index) {
                // Tampilkan timestamp di paling atas
                if (index == 0) {
                  return _buildTimestamp("Sunday, Feb 9, 12:58", subtitleColor);
                }
                
                final msg = _chatMessages[index - 1]; // Kurangi 1 untuk offset timestamp
                
                if (msg['sender'] == 'Me') {
                  if (msg['type'] == 'image') {
                    return _buildImageBubble(msg['image']!);
                  }
                  return _buildSenderBubble(msg['text']!);
                } else {
                  return _buildReceiverBubble(
                    msg['text']!,
                    msg['sender']!,
                    msg['sender'] == 'Kate' ? kateAvatar : ninjaAvatar,
                    subtitleColor
                  );
                }
              },
            ),
          ),

          // --- Bagian Input Teks ---
          _buildTextInputArea(subtitleColor),
        ],
      ),
    );
  }

  // Widget untuk timestamp
  Widget _buildTimestamp(String time, Color color) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          time,
          style: TextStyle(color: color, fontSize: 13),
        ),
      ),
    );
  }

  // Widget untuk gelembung Pengirim (Me)
  Widget _buildSenderBubble(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue, // Warna biru untuk pengirim
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(5), // Sudut lancip
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Widget untuk gelembung gambar Pengirim (Me)
  Widget _buildImageBubble(String imageUrl) {
     return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              width: 250, // Lebar gambar
              height: 300, // Tinggi gambar
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(5),
                ),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk gelembung Penerima (Kate, Blue Ninja)
  Widget _buildReceiverBubble(String text, String senderName, String avatarUrl, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(avatarUrl),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  senderName,
                  style: TextStyle(color: color, fontSize: 13),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300, // Warna abu-abu
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5), // Sudut lancip
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk area input teks di bawah
  Widget _buildTextInputArea(Color subtitleColor) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          // Tombol Kamera
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, size: 28),
            color: subtitleColor,
            onPressed: () {
              // TODO: Logika ambil gambar
            },
          ),
          
          // Input Teks
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Message",
                  hintStyle: TextStyle(color: subtitleColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          
          // Tombol Kirim
          IconButton(
            icon: const Icon(Icons.send_rounded, size: 28),
            color: subtitleColor,
            onPressed: () {
              // TODO: Logika kirim pesan
            },
          ),
        ],
      ),
    );
  }
}