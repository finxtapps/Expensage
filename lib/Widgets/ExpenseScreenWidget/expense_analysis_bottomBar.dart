import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ExpenseBottomBar extends StatefulWidget {
  const ExpenseBottomBar({super.key});

  @override
  _ExpenseBottomBarState createState() => _ExpenseBottomBarState();
}

class _ExpenseBottomBarState extends State<ExpenseBottomBar> {
  final int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const <Widget>[
          Icon(Icons.home_rounded, size: 40, color: Colors.white),
          Icon(Icons.analytics_rounded, size: 40, color: Colors.white),
          Icon(Icons.person_2_rounded, size: 40, color: Colors.white),
          Icon(Icons.settings, size: 40, color: Colors.white),
        ],
        color: const Color(0xFFE16472),
        buttonBackgroundColor: const Color(0XFFD44D5C),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/analytics');
              break;
          // case 2:
          //   Navigator.pushNamed(context, '/add');
          //   break;
          // case 3:
          //   Navigator.pushNamed(context, '/profile');
          //   break;
          // case 4:
          //   Navigator.pushNamed(context, '/settings');
          //   break;
          }
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
