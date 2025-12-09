// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart';
import 'package:coba_1/core/theme_provider.dart';
import 'package:coba_1/features/settings/widgets/color_palette_sheet.dart';
import 'package:coba_1/features/job/recent_job_screen.dart';
import 'package:coba_1/features/job/job_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Data State Bookmark
  final List<Map<String, dynamic>> featuredJobs = [
    {'logo': 'assets/images/cosax.png', 'company': 'Cosax Studios', 'title': 'Software Engineer', 'location': 'Medan, Indonesia', 'salary': '\$500 - \$1000', 'isBookmarked': true},
    {'logo': 'assets/images/cosax2.png', 'company': 'Cosax Studios', 'title': 'Senior Progammer', 'location': 'Medan, Indonesia', 'salary': '\$900 - \$1500', 'isBookmarked': false},
    {'logo': 'assets/images/cosax3.png', 'company': 'Cosax Studios', 'title': 'UI/UX Designer', 'location': 'Medan, Indonesia', 'salary': '\$700 - \$1500', 'isBookmarked': false},
  ];
  final List<Map<String, dynamic>> recentJobs = [
    {'logo': 'assets/images/cosax4.png', 'title': 'Junior Software Engineer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1000', 'isBookmarked': false},
    {'logo': 'assets/images/cosax3.png', 'title': 'Software Engineer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1000', 'isBookmarked': true},
    {'logo': 'assets/images/cosax2.png', 'title': 'Graphic Designer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1000', 'isBookmarked': false},
    {'logo': 'assets/images/cosax.png', 'title': 'Software Engineer', 'company': 'Medan, Indonesia', 'salary': '\$500 - \$1000', 'isBookmarked': true},
  ];

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const JobDetailScreen()),
    );
  }

  void _toggleBookmark(List<Map<String, dynamic>> jobList, int index) {
    setState(() {
      jobList[index]['isBookmarked'] = !jobList[index]['isBookmarked'];
    });
  }
  
  void _showColorPalette(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const ColorPaletteSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: _buildAppBar(context, themeProvider),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(titleColor, subtitleColor),
            _buildSearchBar(),
            _buildRecomendedBanner(),
            _buildStatsCards(),
            _buildJobCategories(primaryColor),
            _buildSectionTitle("Featured Jobs", titleColor, primaryColor),
            _buildFeaturedJobsList(),
            _buildSectionTitle("Recent Jobs List", titleColor, primaryColor, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecentJobScreen()),
              );
            }),
            _buildRecentJobsList(),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, ThemeProvider themeProvider) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.palette_outlined, color: Theme.of(context).hintColor),
          onPressed: () {
            _showColorPalette(context); 
          },
        ),
        IconButton(
          icon: Icon(
            themeProvider.isDarkMode 
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
            color: Theme.of(context).hintColor,
          ),
          onPressed: () {
            final provider = Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(!provider.isDarkMode);
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildHeader(Color titleColor, Color subtitleColor) {
    final user = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello", style: TextStyle(color: subtitleColor, fontSize: 20)),
              // --- INTEGRASI FIREBASE: Menampilkan Nama User ---
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading...", style: TextStyle(color: titleColor, fontSize: 26, fontWeight: FontWeight.bold));
                  }
                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    // Jika field 'username' ada, tampilkan. Jika tidak, "User"
                    String name = data['username'] ?? "User";
                    return Text(
                      name,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  return Text("Guest", style: TextStyle(color: titleColor, fontSize: 26, fontWeight: FontWeight.bold));
                },
              ),
            ],
          ),
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/user1.jpg'), 
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
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
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color!),
          decoration: InputDecoration(
            hintText: "Search job here...",
            hintStyle: TextStyle(color: Theme.of(context).hintColor.withOpacity(0.5)),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search, color: Theme.of(context).hintColor.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  Widget _buildRecomendedBanner() {
    const Color bannerColor = Color.fromARGB(255, 111, 0, 255); 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bannerColor, 
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recomended Jobs", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("See our recommendations job for you based your skills", style: TextStyle(color: Color(0xFFE9DFFF), fontSize: 14)),
                ],
              ),
            ),
            Image.asset('assets/images/onboarding_image_2.png', width: 100), 
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          _buildStatCard("45", "Jobs Applied"),
          const SizedBox(width: 16),
          _buildStatCard("28", "Interviews"),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
             BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(label, style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCategories(Color primaryColor) {
    final Color designerColor = const Color.fromARGB(255, 3, 88, 179);
    final Color managerColor = const Color(0xFF27AE60);
    final Color programmerColor = const Color(0xFF8B4513);
    final Color uiuxColor = const Color.fromARGB(255, 12, 126, 59);
    final Color potoColor = const Color.fromARGB(255, 139, 38, 221);

    void _navigateToRecentJobs() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RecentJobScreen()),
      );
    }

    return Column(
      children: [
        _buildSectionTitle(
          "Job Categories", 
          Theme.of(context).textTheme.bodyLarge!.color!, 
          primaryColor, 
          _navigateToRecentJobs
        ),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              _buildCategoryChip("Designer", designerColor, Colors.white, _navigateToRecentJobs),
              _buildCategoryChip("Manager", managerColor, Colors.white, _navigateToRecentJobs),
              _buildCategoryChip("Programmer", programmerColor, Colors.white, _navigateToRecentJobs),
              _buildCategoryChip("UI/UX Designer", uiuxColor, Colors.white, _navigateToRecentJobs),
              _buildCategoryChip("Photographer", potoColor, Colors.white, _navigateToRecentJobs),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, Color color, Color textColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Chip(
          label: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide.none,
          ),
        ),
      ),
    );
  }


 Widget _buildSectionTitle(String title, Color titleColor, Color primaryColor, [VoidCallback? onMoreTap]) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (onMoreTap != null) 
            GestureDetector(
              onTap: onMoreTap,
              child: Text(
                "More", 
                style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold)
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildFeaturedJobsList() {
    return SizedBox(
      height: 200, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: featuredJobs.length,
        itemBuilder: (context, index) {
          final job = featuredJobs[index];
          return _buildFeaturedJobCard(
            job['logo']!,
            job['company']!,
            job['title']!,
            job['location']!,
            job['salary']!,
            job['isBookmarked']!,
            () => _toggleBookmark(featuredJobs, index),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedJobCard(
    String logo,
    String company,
    String title,
    String location,
    String salary,
    bool isBookmarked,
    VoidCallback onBookmarkTap,
  ) {
    final Color cardColor = Theme.of(context).cardColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return GestureDetector( 
    onTap: () => _navigateToDetail(context), 
    child: Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(logo, width: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  company,
                  style: TextStyle(color: subtitleColor, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.yellow[800] : subtitleColor,
                ),
                onPressed: onBookmarkTap,
              ),
            ],
          ),
          const Spacer(),
          Text(title, style: TextStyle(color: titleColor, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(location, style: TextStyle(color: subtitleColor, fontSize: 14)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(salary, style: TextStyle(color: subtitleColor, fontSize: 16)),
              Icon(Icons.arrow_forward_ios_rounded, color: titleColor, size: 16),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildRecentJobsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: recentJobs.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> job = entry.value;
          return _buildRecentJobCard(
            job['logo']!,
            job['title']!,
            job['company']!,
            job['salary']!,
            job['isBookmarked']!,
            () => _toggleBookmark(recentJobs, index),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecentJobCard(
    String logo,
    String title,
    String company,
    String salary,
    bool isBookmarked,
    VoidCallback onBookmarkTap,
  ) {
    final Color cardColor = Theme.of(context).cardColor;
    final Color subtitleColor = Theme.of(context).hintColor;
    final Color primaryColor = Theme.of(context).primaryColor;

    return GestureDetector( 
    onTap: () => _navigateToDetail(context), 
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ]
      ),
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