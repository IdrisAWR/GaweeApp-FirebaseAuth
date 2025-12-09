// lib/setting_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart'; // Impor AppDrawer Anda
import 'package:coba_1/core/theme_provider.dart'; // Impor ThemeProvider kita

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  // State untuk BottomNavBar (Calendar dipilih di gambar)
  int _bottomNavIndex = 1; 

  // Daftar warna (tetap sama)
  final List<Map<String, Color>> colors = const [
    {"Red": Colors.red},
    {"Green": Colors.green},
    {"Blue": Colors.blue},
    {"Pink": Colors.pink},
    {"Yellow": Colors.brown},
    {"Orange": Colors.orange},
    {"Purple": Colors.purple},
    {"Deeppurple": Colors.deepPurple},
    {"Lightblue": Colors.blueAccent},
    {"Teal": Colors.teal},
    {"Lime": Colors.lime},
    {"Deeporange": Colors.deepOrange},
  ];
  
  // --- HELPER BARU: Konversi Color ke String HEX ---
  String _colorToHexString(Color color) {
    // Hapus 2 karakter pertama (FF untuk alpha) dan ubah ke huruf besar
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(), // Drawer tetap terhubung
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: titleColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Color Themes",
          style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          // --- KOREKSI 1: Ganti IconButton dengan TextButton "Link" ---
          TextButton(
            onPressed: () {
              // TODO: Logika untuk tombol "Link"
            },
            child: Text(
              "Link",
              style: TextStyle(
                color: Theme.of(context).primaryColor, // Warna ungu
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 10), // Beri sedikit padding
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Layout Themes", titleColor),
            _buildLayoutThemeSection(context, themeProvider),
            const SizedBox(height: 30),

            _buildSectionTitle("Default Color Themes", titleColor),
            _buildDefaultColorSection(context, themeProvider),
            const SizedBox(height: 30),

            // --- KOREKSI 2: Kirim provider ke 'Custom Color' ---
            _buildSectionTitle("Custom Color Theme", titleColor),
            _buildCustomColorSection(context, themeProvider), // Kirim themeProvider
          ],
        ),
      ),
      // --- KOREKSI 3: Tambahkan BottomNavigationBar ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
          // TODO: Tambahkan navigasi untuk Inbox, Calendar, Upload
        },
        selectedItemColor: Theme.of(context).primaryColor, // Warna item aktif
        unselectedItemColor: Theme.of(context).hintColor, // Warna item inaktif
        showUnselectedLabels: true, // Tampilkan label walau tidak aktif
        type: BottomNavigationBarType.fixed, // Pastikan semua item terlihat
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: Badge( // Widget Badge untuk notifikasi '5'
              label: Text('5'),
              child: Icon(Icons.calendar_today),
            ),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file_outlined),
            label: "Upload",
          ),
        ],
      ),
    );
  }

  // (Helper _buildSectionTitle, _buildLayoutThemeSection, _buildThemeBox, _buildDefaultColorSection, _buildColorButton tetap sama)
  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  
  Widget _buildLayoutThemeSection(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Framework7 comes with 2 main layout themes: Light (default) and Dark:",
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 15, height: 1.4),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildThemeBox(
                  context,
                  isActive: !themeProvider.isDarkMode,
                  onTap: () {
                    themeProvider.toggleTheme(false);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildThemeBox(
                  context,
                  isDark: true,
                  isActive: themeProvider.isDarkMode,
                  onTap: () {
                    themeProvider.toggleTheme(true);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  
  Widget _buildThemeBox(BuildContext context, {bool isDark = false, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: isActive
            ? Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 20),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildDefaultColorSection(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Framework7 comes with 12 color themes set.",
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 15, height: 1.4),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: colors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              final colorEntry = colors[index].entries.first;
              final colorName = colorEntry.key;
              final colorValue = colorEntry.value;
              return _buildColorButton(context, colorName, colorValue, themeProvider);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildColorButton(BuildContext context, String name, Color color, ThemeProvider themeProvider) {
    return ElevatedButton(
      onPressed: () {
        themeProvider.setLightBackgroundFromPal(color);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  // --- KOREKSI 2: Perbarui fungsi ini ---
  Widget _buildCustomColorSection(BuildContext context, ThemeProvider themeProvider) {
    // Ambil warna yang dipilih dari provider
    final Color selectedColor = themeProvider.selectedPaletteColor;
    // Konversi ke HEX
    final String hexString = _colorToHexString(selectedColor);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(context),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: selectedColor, // Gunakan warna dinamis
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HEX Color",
                style: TextStyle(color: Theme.of(context).hintColor, fontSize: 14),
              ),
              const SizedBox(height: 3),
              Text(
                hexString, // Gunakan string HEX dinamis
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge!.color!),
              ),
            ],
          )
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}