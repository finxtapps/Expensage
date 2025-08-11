
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../Screens/expense_analysis_screen.dart';
import '../../Screens/new_home_screen.dart';
import '../../Screens/profile_Information.dart';
import '../../Screens/setting_Screen.dart';
import '../../addButton.dart';

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({super.key});

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  int _selectedIndex = 0; // Screen index
  int _navigationIndex = 0; // Navigation bar index

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      NewHomeScreen(),
      ExpenseAnalysisScreen(),
      SizedBox.shrink(), // dummy for center
      ProfileInfoScreen(),
      SettingsScreen(),
    ];
  }

  void _onTap(int index) {
    if (index == 2) {
      // Center button — Bilkul ignore
      // Navigation bar ko force karo previous index par
      setState(() {
        _navigationIndex = _selectedIndex;
      });

      return ;
    }

    setState(() {
     _selectedIndex = index;
      _navigationIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: CurvedNavigationBar(
            index: _navigationIndex,// stays same when center tapped
            height: 60,
            items:  [
              Icon(Icons.home_rounded, size: 40, color: Colors.white),
              Icon(Icons.analytics_rounded, size: 40, color: Colors.white),
              SizedBox(width: 0, height: 0), // dummy
              Icon(Icons.person_2_rounded, size: 40, color: Colors.white),
              Icon(Icons.settings, size: 40, color: Colors.white),
            ],
            color:_navigationIndex==2?Colors.transparent: Theme.of(context).colorScheme.primary,
            buttonBackgroundColor:_navigationIndex==2?Colors.transparent: isDarkMode
                ?  Color(0xFFD44D5C)
                : Theme.of(context).colorScheme.secondary,
            backgroundColor: isDarkMode
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.white,
            animationCurve:  Curves.easeInOut,
            animationDuration: _navigationIndex == 2 ? Duration.zero:  Duration(milliseconds: 600),
            onTap: _onTap,
          ),
        ),
         AddButton(),
      ],
    );
  }
}









//
//
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
//
// import '../../Screens/expense_analysis_screen.dart';
// import '../../Screens/new_home_screen.dart';
// import '../../Screens/profile_Information.dart';
// import '../../Screens/setting_Screen.dart';
// import '../../addButton.dart';
//
// class MainScreenWrapper extends StatefulWidget {
//   const MainScreenWrapper({super.key});
//
//   @override
//   State<MainScreenWrapper> createState() => _MainScreenWrapperState();
// }
//
// class _MainScreenWrapperState extends State<MainScreenWrapper> {
//   int _selectedIndex = 0;
//   int _previousIndex = 0;
//
//   late final List<Widget> _screens;
//
//   @override
//   void initState() {
//     super.initState();
//     _screens = const [
//       NewHomeScreen(),
//       ExpenseAnalysisScreen(),
//       SizedBox.shrink(), // Placeholder for Add Button
//       ProfileInfoScreen(),
//       SettingsScreen(),
//     ];
//   }
//
//   void _onTap(int index) {
//     if (index != 2) {
//       setState(() {
//         _previousIndex = _selectedIndex;
//         _selectedIndex = index;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Stack(
//       children: [
//         Scaffold(
//           body: IndexedStack(
//             index: _selectedIndex,
//             children: _screens,
//           ),
//           bottomNavigationBar: CurvedNavigationBar(
//             index: _selectedIndex == 2 ? _previousIndex : _selectedIndex,
//             height: 60,
//             items: const [
//               Icon(Icons.home_rounded, size: 40, color: Colors.white),
//               Icon(Icons.analytics_rounded, size: 40, color: Colors.white),
//               SizedBox(width: 0, height: 0), // Placeholder for Add Button
//               Icon(Icons.person_2_rounded, size: 40, color: Colors.white),
//               Icon(Icons.settings, size: 40, color: Colors.white),
//             ],
//             color: Theme.of(context).colorScheme.primary,
//             buttonBackgroundColor: isDarkMode
//                 ? const Color(0xFFD44D5C)
//                 : Theme.of(context).colorScheme.secondary,
//             backgroundColor: isDarkMode
//                 ? Theme.of(context).scaffoldBackgroundColor
//                 : Colors.white,
//             animationCurve: Curves.easeInOut,
//             animationDuration: const Duration(milliseconds: 600),
//             onTap: _onTap,
//           ),
//         ),
//
//         // Positioned Add Button
//         const AddButton(),
//       ],
//     );
//   }
// }
