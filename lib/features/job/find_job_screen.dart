// lib/find_job_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart'; // Impor AppDrawer Anda
import 'company_list_screen.dart';
import 'package:coba_1/features/resume/resume_screen.dart';

class FindJobScreen extends StatefulWidget {
  const FindJobScreen({Key? key}) : super(key: key);

  @override
  _FindJobScreenState createState() => _FindJobScreenState();
}

class _FindJobScreenState extends State<FindJobScreen> {
  // Key untuk mengontrol Scaffold (agar tombol '...' bisa buka drawer)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Daftar dummy untuk popular searches
  final List<String> popularSearches = [
    "Software developer fresher",
    "Worker From Home",
    "Driver",
    "hr frsher",
    "softwere testing",
    "seles executive",
    "business analyst",
    "receptionist",
    "data analyst",
    "seo executive",
  ];

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
          "Find Job",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Search Form Card ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                children: [
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: subtitleColor),
                      hintText: "job title, keywords, or company",
                      hintStyle: TextStyle(color: subtitleColor.withOpacity(0.7)),
                      border: InputBorder.none,
                    ),
                  ),
                  Divider(color: Colors.grey.shade200),
                  TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_on, color: subtitleColor),
                      hintText: "Enter city or locality",
                      hintStyle: TextStyle(color: subtitleColor.withOpacity(0.7)),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- Search Button ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman Company List
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CompanyListScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "SEARCH",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- Popular Searches ---
            Text(
              "Popular Searches",
              style: TextStyle(
                color: titleColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10.0, // Jarak horizontal antar chip
              runSpacing: 10.0, // Jarak vertikal antar baris chip
              children: popularSearches.map((search) {
                return _buildSearchChip(search, subtitleColor);
              }).toList(),
            ),
            const SizedBox(height: 30),

            // --- Create Resume Link ---
            GestureDetector(
              onTap: () {
                // Navigasi ke halaman Resume
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResumeScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create Your Resume",
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: titleColor, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk chip
  Widget _buildSearchChip(String label, Color color) {
    return Chip(
      avatar: Icon(Icons.search, color: color, size: 18),
      label: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      backgroundColor: Theme.of(context).cardColor,
      side: BorderSide(color: Colors.grey.shade300),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }
}