import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/header_Color.dart';
import '../../theme/theme_provider.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

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
          padding:  EdgeInsets.symmetric(
              vertical:MediaQuery.of(context).size.height*0.02 ,

              horizontal: 20),
          child: Row(
            children: [

              const SizedBox(width: 20),
              const Text(
                'Settings',
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