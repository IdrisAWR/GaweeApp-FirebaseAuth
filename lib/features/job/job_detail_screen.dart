// lib/job_detail_screen.dart
import 'package:flutter/material.dart';
import 'available_jobs_screen.dart'; // Impor placeholder
import 'package:coba_1/shared_widgets/app_drawer.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({Key? key}) : super(key: key);

  @override
  _JobDetailScreenState createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController(); // Controller untuk mendeteksi scroll
  double _appBarOpacity = 0.0; // Opasitas AppBar

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    // --- PERBAIKAN: Listener untuk mendeteksi scroll dan mengubah opasitas AppBar ---
    _scrollController.addListener(() {
      // Offset saat AppBar mulai mendapatkan background
      // Sesuaikan nilai ini agar sesuai dengan desain Anda
      const double scrollThreshold = 150.0; 

      if (_scrollController.offset > scrollThreshold) {
        // Jika sudah melewati batas, set opasitas penuh
        if (_appBarOpacity != 1.0) {
          setState(() {
            _appBarOpacity = 1.0;
          });
        }
      } else {
        // Jika belum melewati batas, set opasitas transparan
        if (_appBarOpacity != 0.0) {
          setState(() {
            _appBarOpacity = 0.0;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    _scrollController.dispose(); // Jangan lupa dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor; // Warna background utama

    return Scaffold(
      // --- PERBAIKAN: Gunakan Stack untuk AppBar yang tumpang tindih ---
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          // Konten yang bisa di-scroll
          SingleChildScrollView(
            controller: _scrollController, // Hubungkan controller
            child: Column(
              children: [
                // Gambar Gedung (tanpa AppBar)
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/detail_jobs.jpg'), // Ganti dengan aset gambar Anda
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Logo Perusahaan (Tepat di bawah gambar gedung)
                Transform.translate( // Untuk menaikkan logo agar terlihat "mengambang"
                  offset: const Offset(0.0, -35.0), // Naikkan 35 pixel
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: backgroundColor, // Background mengikuti tema
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0,5))
                      ]
                    ),
                    child: Image.asset(
                      'assets/images/cosax4.png', // Logo ungu
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                // Padding ekstra untuk "menggantikan" ruang yang diambil oleh transform
                const SizedBox(height: 10), 
                
                // --- KONTEN UTAMA ---
                Text(
                  "Software Engineer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Medan, Indonesia",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: subtitleColor, fontSize: 16),
                ),
                const SizedBox(height: 20),

                _buildAvailableJobsBanner(context),
                const SizedBox(height: 20),

                // --- TAB BAR ---
                TabBar(
                  controller: _tabController,
                  labelColor: primaryColor,
                  unselectedLabelColor: subtitleColor,
                  indicatorColor: primaryColor,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  tabs: const [
                    Tab(text: "ABOUT US"),
                    Tab(text: "RATINGS"),
                    Tab(text: "REVIEW"),
                  ],
                ),
                
                // --- KONTEN TAB ---
                Container(
                  padding: const EdgeInsets.all(24),
                  child: [
                    _buildAboutUsTab(titleColor, subtitleColor),
                    _buildRatingsTab(titleColor, subtitleColor),
                    _buildReviewTab(titleColor, subtitleColor),
                  ][_tabController.index],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // --- PERBAIKAN: Custom AppBar di atas konten yang di-scroll ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity( // Gunakan AnimatedOpacity untuk transisi halus
              opacity: _appBarOpacity,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: backgroundColor, // Background AppBar
                child: AppBar(
                  backgroundColor: Colors.transparent, // AppBar tetap transparan
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: titleColor), // Warna ikon disesuaikan tema
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(
                    "Software Engineer",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.more_vert, color: Theme.of(context).hintColor),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer(); // Buka drawer
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // AppBar awal (yang selalu ada dan transparan)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent, // Selalu transparan
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 5, 5, 5)), // Selalu putih
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Opacity( // Judul awal transparan
                opacity: 1.0 - _appBarOpacity, // Semakin background AppBar terlihat, judul ini semakin hilang
                child: const Text(
                  "Software Engineer",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer(); // Buka drawer
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // --- WIDGET UNTUK KONTEN TAB (TIDAK BERUBAH) ---

  Widget _buildAboutUsTab(Color titleColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          style: TextStyle(color: subtitleColor, fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 20),
        Text(
          "Requirements",
          style: TextStyle(color: titleColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in",
          style: TextStyle(color: subtitleColor, fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 20),
        _buildRequirementRow("Sed ut perspiciatis unde omnis", subtitleColor),
        _buildRequirementRow("Doloremque laudantium", subtitleColor),
        _buildRequirementRow("Ipsa quae ab illo inventore", subtitleColor),
        _buildRequirementRow("Architecto beatae vitae dicta", subtitleColor),
        _buildRequirementRow("Sunt explicabo", subtitleColor),
      ],
    );
  }

  Widget _buildRequirementRow(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: color, fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsTab(Color titleColor, Color subtitleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ratings Bars",
          style: TextStyle(color: titleColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              "4.0",
              style: TextStyle(color: titleColor, fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (index) => Icon(
                    index < 4 ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                    size: 20,
                  )),
                ),
                const SizedBox(height: 5),
                Text(
                  "78,320",
                  style: TextStyle(color: subtitleColor, fontSize: 14),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        _buildRatingBar(0.9), // 5 Bintang
        _buildRatingBar(0.7), // 4 Bintang
        _buildRatingBar(0.5), // 3 Bintang
        _buildRatingBar(0.3), // 2 Bintang
        _buildRatingBar(0.1), // 1 Bintang
      ],
    );
  }

  Widget _buildRatingBar(double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 10,
          backgroundColor: Colors.grey.shade200,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildReviewTab(Color titleColor, Color subtitleColor) {
    return Column(
      children: [
        _buildReviewItem(
          "assets/images/1.jpg",
          "James Logan",
          "27 August 2020",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          4, // Rating
          subtitleColor,
          titleColor, // Tambahkan titleColor
        ),
        _buildReviewItem(
          "assets/images/2.jpg",
          "Leo Tucker",
          "15 June 2020",
          "Phasellus vel felis tellus. Mauris rutrum ligula nec dapibus feugiat. In vel dui laoreet, commodo augue id,...",
          5, // Rating
          subtitleColor,
          titleColor, // Tambahkan titleColor
        ),
        _buildReviewItem(
          "assets/images/3.jpg",
          "Oscar Weston",
          "07 June 2020",
          "Mauris rutrum ligula nec dapibus feugiat. In vel dui laoreet, commodo augue id,...",
          4, // Rating
          subtitleColor,
          titleColor, // Tambahkan titleColor
        ),
        _buildReviewItem(
          "assets/images/4.jpg",
          "Yellow Submarine",
          "25 May 2020",
          "Nulla vitae elit libero, a pharetra augue. Mauris dapibus feugiat. In vel dui laoreet, commodo augue id,...",
          4, // Rating
          subtitleColor,
          titleColor, // Tambahkan titleColor
        ),
      ],
    );
  }

  Widget _buildReviewItem(String imageUrl, String name, String date, String review, int rating, Color subtitleColor, Color titleColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(imageUrl),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: titleColor),
                    ),
                    Text(
                      date,
                      style: TextStyle(color: subtitleColor, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 16,
                )),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review,
            style: TextStyle(color: subtitleColor, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableJobsBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AvailableJobsScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "21 Available Jobs",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}