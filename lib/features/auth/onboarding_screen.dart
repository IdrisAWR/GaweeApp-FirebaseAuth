import 'package:flutter/material.dart';
import 'pilih_peran_screen.dart';
// Untuk sementara, kita akan membuat halaman utama palsu untuk navigasi
// import 'home_screen.dart'; // Nanti akan diganti dengan halaman utama sebenarnya

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0; // Untuk melacak halaman yang sedang aktif

  // Data dummy untuk setiap slide onboarding
  // Anda bisa ganti Path Gambar dan Deskripsi ini nanti
  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding_image_1.png', // Ganti dengan path aset Anda
      'title': 'Let\'s get started',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    },
    {
      'image': 'assets/images/onboarding_image_2.png', // Ganti dengan path aset Anda
      'title': 'Recomended Jobs',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    },
    {
      'image': 'assets/images/onboarding_image_1.png', // Ganti dengan path aset Anda
      'title': 'Let\'s get started',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF673AB7); // Warna ungu utama

    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih/terang
      body: SafeArea( // Pastikan konten tidak tumpang tindih dengan status bar
        child: Column(
          children: <Widget>[
            // 1. Logo "Gawee" di bagian atas (sama seperti di splash screen)
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(
                'assets/images/logo_gawee1.png', // Pastikan path dan nama file ini benar
                width: 80, // Sesuaikan ukuran logonya
              ),
            ),
            const SizedBox(height: 40),
            // const Text(
            //   "Gawee",
            //   style: TextStyle(
            //     fontSize: 24,
            //     color: Color(0xFF673AB7), // Warna ungu untuk teks Gawee
            //     fontWeight: FontWeight.bold,
            //     fontFamily: 'Poppins',
            //   ),
            // ),
            
            Expanded( // PageView akan mengambil sisa ruang yang tersedia di tengah
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return buildOnboardingSlide(
                    onboardingData[index]['image']!,
                    onboardingData[index]['title']!,
                    onboardingData[index]['description']!,
                  );
                },
              ),
            ),
            
            // Indikator Titik
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDotIndicator(index, _currentPage == index),
              ),
            ),
            const SizedBox(height: 100), // Jarak antara titik dan tombol
            
            // Tombol "Get Started"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                width: double.infinity, // Membuat tombol selebar mungkin
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman utama
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const PilihPeranScreen(), // <--- INI KODE LAMA (placeholder)
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // Warna ungu
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Sudut melengkung
                    ),
                    elevation: 2, // Sedikit bayangan
                  ),
                  child: const Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40), // Jarak dari bawah layar
          ],
        ),
      ),
    );
  }

  // Widget untuk satu slide onboarding
  Widget buildOnboardingSlide(String imagePath, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Gambar utama
        Image.asset(
          imagePath,
          height: 170, // Sesuaikan ukuran gambar
        ),
        const SizedBox(height: 50),
        
        // Judul
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        
        // Deskripsi
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55.0),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // Widget untuk indikator titik
  Widget buildDotIndicator(int index, bool isActive) {
    Color primaryColor = Color(0xFF673AB7);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 10,
      width: isActive ? 30 : 10, // Titik aktif lebih panjang
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}