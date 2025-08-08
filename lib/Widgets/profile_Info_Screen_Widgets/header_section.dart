import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uiproject/Widgets/profile_Info_Screen_Widgets/profile_image_section.dart';

import '../../theme/header_Color.dart';
import '../../theme/theme_provider.dart';

class ProfileHeaderSection extends StatelessWidget {
  final VoidCallback onBackPressed;

  const ProfileHeaderSection({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height:MediaQuery.of(context).size.height * 0.35,/////////////////////
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 2),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onBackPressed,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24), // Balance the back button
                ],
              ),
              const SizedBox(height: 10),
              const ProfileImageSection(),
              // SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}