// lib/elements_screen.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/app_drawer.dart'; // Impor AppDrawer Anda

class ElementsScreen extends StatefulWidget {
  const ElementsScreen({Key? key}) : super(key: key);

  @override
  _ElementsScreenState createState() => _ElementsScreenState();
}

class _ElementsScreenState extends State<ElementsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // --- PERUBAHAN DI SINI: Tambahkan state untuk pencarian ---
  bool _isSearching = false;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<String> components = [
    "Accordion",
    "Action Sheet",
    "Appbar",
    "Autocomplete",
    "Badge",
    "Buttons",
    "Calendar / Date Picker",
    "Cards",
    "Cards Expandable",
    "Checkbox",
    "Chips / Tags",
    "Color Picker", // Saya tambahkan ini dari gambar Anda
  ];
  
  @override
  void dispose() {
    _searchController.dispose(); // Jangan lupa dispose controller
    super.dispose();
  }

  // --- WIDGET AppBar Normal ---
  AppBar _buildDefaultAppBar(BuildContext context) {
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu, color: titleColor, size: 28),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text(
        "Framework7",
        style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: titleColor, size: 28),
          onPressed: () {
            // Ganti ke mode pencarian
            setState(() {
              _isSearching = true;
            });
          },
        )
      ],
    );
  }

  // --- WIDGET AppBar Pencarian (BARU) ---
  AppBar _buildSearchAppBar(BuildContext context) {
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: titleColor),
        onPressed: () {
          // Kembali ke mode normal
          setState(() {
            _isSearching = false;
            _searchQuery = "";
            _searchController.clear();
          });
        },
      ),
      title: TextField(
        controller: _searchController,
        autofocus: true, // Langsung fokus ke search bar
        style: TextStyle(color: titleColor, fontSize: 18),
        decoration: InputDecoration(
          hintText: "Search components",
          hintStyle: TextStyle(color: subtitleColor.withOpacity(0.7)),
          border: InputBorder.none,
        ),
        onChanged: (query) {
          // Update query saat mengetik
          setState(() {
            _searchQuery = query;
          });
        },
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;

    // --- Logika Filter ---
    final List<String> filteredComponents = components.where((component) {
      return component.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      // --- PERUBAHAN DI SINI: Ganti AppBar dinamis ---
      appBar: _isSearching ? _buildSearchAppBar(context) : _buildDefaultAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sembunyikan judul "Framework7" saat mencari
            if (!_isSearching)
              Text(
                "Framework7",
                style: TextStyle(
                  color: titleColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (!_isSearching) const SizedBox(height: 20),

            // Sembunyikan "About" saat mencari
            if (!_isSearching)
              _buildComponentTile(
                context,
                "About Framework7",
                Icons.info_outline,
                () { /* Navigasi */ },
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.05),
              ),
            if (!_isSearching) const SizedBox(height: 30),
            
            // Tampilkan "Components" hanya jika tidak mencari ATAU jika mencari & ada hasil
            if (!_isSearching || filteredComponents.isNotEmpty)
              Text(
                "Components",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (!_isSearching || filteredComponents.isNotEmpty) const SizedBox(height: 10),

            // --- Daftar Komponen (sudah difilter) ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredComponents.length, // Gunakan daftar yang sudah difilter
              itemBuilder: (context, index) {
                return _buildComponentTile(
                  context,
                  filteredComponents[index], // Gunakan daftar yang sudah difilter
                  Icons.business_center_outlined, 
                  () {
                    // TODO: Navigasi ke detail komponen
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // (Widget helper _buildComponentTile tidak berubah)
  Widget _buildComponentTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    Color? backgroundColor,
  }) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color subtitleColor = Theme.of(context).hintColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (backgroundColor == null) 
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: primaryColor, size: 22),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: subtitleColor, size: 16),
          ],
        ),
      ),
    );
  }
}