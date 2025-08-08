import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/header_Color.dart';
import '../../theme/theme_provider.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
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
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20),
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
                'Notification',
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
    );
  }
}
