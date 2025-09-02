import 'package:flutter/material.dart';
import 'package:uiproject/component/header_appbar.dart';

import '../Widgets/settingScreenWidgets/SettingsContent.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
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