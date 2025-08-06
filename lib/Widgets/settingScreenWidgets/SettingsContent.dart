

import 'package:flutter/material.dart';

import '../../theme/theme_provider.dart';

class SettingsContent extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggleDarkMode;

  const SettingsContent({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        color:isDarkMode?Theme.of(context).primaryColor  :Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildSettingItem(
                context,
                icon: Icons.attach_money,
                title: 'Currency',
                hasArrow: true,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Currency settings would open here'),
                    ),
                  );
                },
              ),

             ////////////////////////////////////

              ///////////////////////////////////////
              const SizedBox(height: 15),
              _buildSettingItem(
                context,
                icon: Icons.brightness_6,
                title: 'Theme',
                hasArrow: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>  ThemePickerDialog(),
                  );
                },
                toggleValue: isDarkMode,
                onToggleChanged: onToggleDarkMode,
              ),
              const SizedBox(height: 15),
              _buildSettingItem(
                context,
                icon: Icons.lock_outline,
                title: 'Password',
                hasArrow: true,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password settings would open here'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildSettingItem(
                context,
                icon: Icons.language,
                title: 'Language',
                hasArrow: true,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Language settings would open here'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildSettingItem(
                context,
                icon: Icons.location_on_outlined,
                title: 'Location',
                hasArrow: true,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Location settings would open here'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              _buildSettingItem(
                context,
                icon: Icons.help_outline,
                title: 'FAQ and support',
                hasArrow: true,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('FAQ and support would open here'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              // SizedBox(height: 80,
              //   width: 200,
              //   child: Builder(
              //         builder: (context) => ThemeButton(), // ✅ Now has valid Provider context
              //       ),
              // )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        bool hasArrow = false,
        bool hasToggle = false,
        bool toggleValue = false,
        ValueChanged<bool>? onToggleChanged,
        VoidCallback? onTap,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: hasToggle ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color:isDarkMode? Theme.of(context).scaffoldBackgroundColor :Theme.of(context).colorScheme.primary.withOpacity(.2), // Light pink/beige color
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:isDarkMode? Colors.white: Colors.black87,
              size: 24,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color:isDarkMode? Colors.white: Colors.black87,
                  fontSize: screenWidth*.042,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (hasArrow)
               Icon(
                Icons.chevron_right,
                color:isDarkMode? Colors.white: Colors.black54,
                size: screenWidth * 0.05,
              ),
            if (hasToggle)
              _buildToggleSwitch(toggleValue, onToggleChanged),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(bool toggleValue, ValueChanged<bool>? onToggleChanged) {
    return Container(
      width: 60,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: toggleValue
              ? [Colors.blue.shade300, Colors.blue.shade600]
              : [Colors.orange.shade300, Colors.orange.shade600],
        ),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: toggleValue ? 30 : 0,
            child: GestureDetector(
              onTap: () {
                if (onToggleChanged != null) {
                  onToggleChanged(!toggleValue);
                }
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}