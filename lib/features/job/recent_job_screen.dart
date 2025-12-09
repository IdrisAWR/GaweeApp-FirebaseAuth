// lib/recent_job_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart'; // Impor drawer Anda
import 'job_detail_screen.dart';

class RecentJobScreen extends StatefulWidget {
  const RecentJobScreen({Key? key}) : super(key: key);

  @override
  _RecentJobScreenState createState() => _RecentJobScreenState();
}

class _RecentJobScreenState extends State<RecentJobScreen> {
  // Key untuk mengontrol Scaffold (agar tombol '...' bisa buka drawer)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Kita salin data dan fungsi bookmark dari home_screen
  // (Di aplikasi nyata, ini akan dikelola oleh Provider)
  final List<Map<String, dynamic>> recentJobs = [
    {'logo': 'assets/images/cosax4.png', 'title': 'Junior Software Engineer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1,000', 'isBookmarked': false},
    {'logo': 'assets/images/cosax3.png', 'title': 'Software Engineer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1,000', 'isBookmarked': true},
    {'logo': 'assets/images/cosax2.png', 'title': 'Graphic Designer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1,000', 'isBookmarked': false},
    {'logo': 'assets/images/cosax.png', 'title': 'Software Engineer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1,000', 'isBookmarked': false},
    {'logo': 'assets/images/cosax3.png', 'title': 'Software Engineer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1,000', 'isBookmarked': false},
    {'logo': 'assets/images/cosax2.png', 'title': 'Graphic Designer', 'company': 'Medan, Indonesia', 'salary': '\$600 - \$1,100', 'isBookmarked': false},
  ];

  void _toggleBookmark(int index) {
    setState(() {
      recentJobs[index]['isBookmarked'] = !recentJobs[index]['isBookmarked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Ambil warna tema
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return Scaffold(
      key: _scaffoldKey, // 1. Terapkan GlobalKey
      drawer: const AppDrawer(), // 2. Tambahkan drawer yang sama
      appBar: AppBar(
        // 3. Tombol Kembali (Arrow back)
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme?.color),
          onPressed: () => Navigator.of(context).pop(), // Kembali ke Home
        ),
        title: Text(
          "Recent Job",
          style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          // 4. Tombol Titik Tiga
          IconButton(
            icon: Icon(Icons.more_vert, color: Theme.of(context).hintColor),
            onPressed: () {
              // Buka drawer dari tombol kanan
              _scaffoldKey.currentState?.openDrawer(); 
            },
          )
        ],
      ),
      body: Column(
        children: [
          // 5. Search Bar
          _buildSearchBar(Theme.of(context).cardColor, subtitleColor, titleColor),
          
          // 6. List dengan Garis Pemisah
          Expanded(
            child: ListView.separated(
              itemCount: recentJobs.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final job = recentJobs[index];
                return _buildRecentJobListItem(
                  context,
                  job['logo']!,
                  job['title']!,
                  job['company']!,
                  job['salary']!,
                  job['isBookmarked']!,
                  () => _toggleBookmark(index),
                );
              },
              // Ini adalah widget untuk garis pemisah
              separatorBuilder: (context, index) => Divider(
                height: 1, // Tinggi garis
                thickness: 1, // Tebal garis
                color: Theme.of(context).hintColor.withOpacity(0.1), // Warna garis
                indent: 24, // Jarak dari kiri
                endIndent: 24, // Jarak dari kanan
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Search Bar (disalin dari home_screen)
  Widget _buildSearchBar(Color cardColor, Color hintColor, Color inputColor) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]
        ),
        child: TextField(
          style: TextStyle(color: inputColor),
          decoration: InputDecoration(
            hintText: "Search job here...",
            hintStyle: TextStyle(color: hintColor.withOpacity(0.5)),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search, color: hintColor.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  // Widget untuk List Item (bukan Card, tapi List Tile biasa)
  Widget _buildRecentJobListItem(
    BuildContext context,
    String logo,
    String title,
    String company,
    String salary,
    bool isBookmarked,
    VoidCallback onBookmarkTap,
  ) {
    // Ambil warna tema
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color subtitleColor = Theme.of(context).hintColor;

    return GestureDetector( // <-- 1. BUNGKUS DENGAN INI
    onTap: () { // <-- 2. TAMBAHKAN ONTAP
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const JobDetailScreen()),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        children: [
          Image.asset(logo, width: 45),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(company, style: TextStyle(color: subtitleColor, fontSize: 14)),
                const SizedBox(height: 5),
                Text(salary, style: TextStyle(color: subtitleColor, fontSize: 14)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border_rounded,
              color: isBookmarked ? Colors.yellow[800] : subtitleColor,
              size: 28,
            ),
            onPressed: onBookmarkTap,
          ),
        ],
      ),
    ),
    );
  }
}