// lib/color_palette_sheet.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coba_1/core/theme_provider.dart';

class ColorPaletteSheet extends StatelessWidget {
  const ColorPaletteSheet({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      
      // --- PERBAIKAN DI SINI ---
      child: SingleChildScrollView( // 1. Bungkus Column dengan SingleChildScrollView
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle abu-abu di atas
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            // Grid 3 kolom
            GridView.builder(
              // 2. Matikan scroll di GridView agar tidak bentrok
              physics: const NeverScrollableScrollPhysics(), 
              shrinkWrap: true,
              itemCount: colors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final colorEntry = colors[index].entries.first;
                final colorName = colorEntry.key;
                final colorValue = colorEntry.value;

                return _buildColorSwatch(context, colorName, colorValue);
              },
            ),
          ],
        ),
      ),
      // --- BATAS PERBAIKAN ---
    );
  }

  Widget _buildColorSwatch(BuildContext context, String name, Color color) {
    return GestureDetector(
      onTap: () {
        Provider.of<ThemeProvider>(context, listen: false)
            .setLightBackgroundFromPal(color);
        Navigator.pop(context); 
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}