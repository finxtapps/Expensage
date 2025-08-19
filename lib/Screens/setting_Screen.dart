import 'package:flutter/material.dart';
import 'package:uiproject/component/header_appbar.dart';

import '../Widgets/settingScreenWidgets/SettingsContent.dart';
import '../Widgets/settingScreenWidgets/settingsHeader.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final int _selectedIndex = 0;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    return Scaffold(
      body: Column(
        children: [

          HeaderAppbar(title: "Settings",
            back_btn: false,),
          // const SettingsHeader(),
          Expanded(
            child: Column(
              children: [
                SettingsContent(
                  isDarkMode: isDarkMode,
                  onToggleDarkMode: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),

              ],
            )
          ),

         // BottomNavBar(selectedIndex: selectedIndex),
        ],
      ),
    );
  }
}