import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/header_Color.dart';
import '../theme/theme_provider.dart';

class ScanFingerprintScreen extends StatefulWidget {
  const ScanFingerprintScreen({super.key});

  @override
  State<ScanFingerprintScreen> createState() => _ScanFingerprintScreenState();
}

class _ScanFingerprintScreenState extends State<ScanFingerprintScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient:
              themeProvider.currentTheme == 'Pink'
                  ? HeaderColor.pinkGradient
                  : themeProvider.currentTheme == 'Green'
                  ? HeaderColor.greenGradient
                  : themeProvider.currentTheme == 'Blue'
                  ? HeaderColor.blueGradient
                  : themeProvider.currentTheme == 'Orange'
                  ? HeaderColor.orangeGradient
                  : HeaderColor.darkGradient,
            ),
            child: SafeArea(
              child: Padding(
                padding:  const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Scan your fingerprint',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          

        ],
      ),
    );
  }
}
