// lib/gallery_screen.dart
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // --- PERUBAHAN 1: Ubah struktur data ---
  final List<Map<String, String>> _galleryData = [
    {
      "image": 'assets/images/beach.jpg',
      "caption": "Amazing beach in Goa, India"
    },
    {
      "image": 'assets/images/mountains.jpg',
      "caption": "Beautiful mountains in Zhangjiajie, China"
    },
    {
      "image": 'assets/images/lock.jpg',
      "caption": "Lock love in Bali, Indonesia"
    },
    {
      "image": 'assets/images/monkey.jpg',
      "caption": "I met this monkey in Chinese mountains"
    },
    {
      "image": 'assets/images/mountains.jpg',
      "caption": "Beautiful mountains in Zhangjiajie, China"
    },
  ];
  
  late PageController _pageController;
  int _currentIndex = 0; 

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color titleColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color cardColor = Theme.of(context).cardColor;
    
    final Color activeArrowColor = Colors.blue.shade600; 
    final Color inactiveArrowColor = Colors.grey.shade400;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          // --- PERUBAHAN 2: Gunakan .length dari data baru ---
          "${_currentIndex + 1} of ${_galleryData.length}", 
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. Gambar (PageView)
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              child: PageView.builder(
                // --- PERUBAHAN 3: Gunakan .length dari data baru ---
                itemCount: _galleryData.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  // --- PERUBAHAN 4: Ambil 'image' dari map ---
                  return Image.asset(
                    _galleryData[index]['image']!,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
          
          // 2. Bagian Bawah (Caption & Navigasi)
          Container(
            padding: EdgeInsets.only(
              top: 20, 
              left: 20, 
              right: 20, 
              bottom: MediaQuery.of(context).padding.bottom + 20
            ),
            color: cardColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  // --- PERUBAHAN 5: Ambil 'caption' dinamis ---
                  _galleryData[_currentIndex]['caption']!, 
                  style: TextStyle(color: titleColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: _currentIndex > 0 ? activeArrowColor : inactiveArrowColor, size: 30),
                      onPressed: _currentIndex > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward, color: _currentIndex < _galleryData.length - 1 ? activeArrowColor : inactiveArrowColor, size: 30),
                      onPressed: _currentIndex < _galleryData.length - 1
                          ? () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}