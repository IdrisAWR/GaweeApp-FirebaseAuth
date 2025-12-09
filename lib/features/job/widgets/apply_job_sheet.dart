// lib/apply_job_sheet.dart
import 'package:flutter/material.dart';
import 'package:coba_1/shared_widgets/custom_form_field.dart'; // Kita gunakan ulang form kustom kita

class ApplyJobSheet extends StatelessWidget {
  const ApplyJobSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Agar tingginya pas dengan konten
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 30),
          
          // Form Fields
          const CustomFormField(hintText: "User Name"),
          const SizedBox(height: 20),
          const CustomFormField(hintText: "Email Address"),
          const SizedBox(height: 20),
          const CustomFormField(hintText: "Phone number"),
          const SizedBox(height: 30),

          // Tombol Submit
          ElevatedButton(
            onPressed: () {
              // TODO: Logika submit
              Navigator.pop(context); // Tutup sheet
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "SUBMIT",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Padding agar tidak terhalang gesture bar iOS/Android
          SizedBox(height: MediaQuery.of(context).padding.bottom + 10), 
        ],
      ),
    );
  }
}