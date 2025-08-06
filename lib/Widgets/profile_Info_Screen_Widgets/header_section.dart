import 'package:flutter/material.dart';
import 'package:uiproject/Widgets/profile_Info_Screen_Widgets/profile_image_section.dart';

class ProfileHeaderSection extends StatelessWidget {
  final VoidCallback onBackPressed;

  const ProfileHeaderSection({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height:MediaQuery.of(context).size.height * 0.3,/////////////////////
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        gradient:isDarkMode? LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary, // First color
            Theme.of(context).colorScheme.primary, // Second color
          ],
        ):LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(.7), // First color
            Theme.of(context).colorScheme.secondary, // Second color
          ],
        ),
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