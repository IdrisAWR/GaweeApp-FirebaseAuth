// lib/company_list_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart'; // Impor AppDrawer Anda
import 'available_jobs_screen.dart'; // Impor tujuan navigasi

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  _CompanyListScreenState createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  // Key untuk mengontrol Scaffold (agar tombol '...' bisa buka drawer)
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Data dummy untuk daftar perusahaan
  final List<Map<String, String>> companyList = [
    {"logo": "assets/images/google.png", "name": "Google", "location": "California, United States", "jobs": "10 Jobs"},
    {"logo": "assets/images/microsoft.png", "name": "Microsoft", "location": "Redmond, Washington, USA", "jobs": "9 Jobs"},
    {"logo": "assets/images/twitter.png", "name": "Twitter", "location": "San Francisco, United States", "jobs": "4 Jobs"},
    {"logo": "assets/images/tencent.png", "name": "Tencent", "location": "Shenzhen, china", "jobs": "4 Jobs"},
    {"logo": "assets/images/google.png", "name": "Google", "location": "California, United States", "jobs": "10 Jobs"},
    {"logo": "assets/images/microsoft.png", "name": "Microsoft", "location": "Redmond, Washington, USA", "jobs": "9 Jobs"},
    {"logo": "assets/images/twitter.png", "name": "Twitter", "location": "San Francisco, United States", "jobs": "4 Jobs"},
    {"logo": "assets/images/tencent.png", "name": "Tencent", "location": "Shenzhen, china", "jobs": "4 Jobs"},
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
          "Company List",
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
          children: [
            // --- Search Bar ---
            Container(
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
                  hintText: "Type Company Name",
                  hintStyle: TextStyle(color: subtitleColor.withOpacity(0.7)),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: subtitleColor.withOpacity(0.7)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- Company List ---
            ListView.builder(
              shrinkWrap: true, // Agar bisa di dalam SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Biarkan SingleChildScrollView yang scroll
              itemCount: companyList.length,
              itemBuilder: (context, index) {
                final company = companyList[index];
                return _buildCompanyCard(
                  context,
                  company['logo']!,
                  company['name']!,
                  company['location']!,
                  company['jobs']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk satu kartu perusahaan
  Widget _buildCompanyCard(
    BuildContext context,
    String logoAsset,
    String name,
    String location,
    String jobs,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke AvailableJobsScreen sesuai permintaan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AvailableJobsScreen()),
        );
      },
      child: Container(
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
        child: Row(
          children: [
            // TODO: Ganti 'logoAsset' dengan path logo Anda yang benar
            Image.asset(logoAsset, width: 45, height: 45, fit: BoxFit.contain),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor, // Warna ungu
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    location,
                    style: TextStyle(color: Theme.of(context).hintColor, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    jobs,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color!, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}