// NEW UPDATED FILE: new_home_screen.dart

import 'package:flutter/material.dart';
import 'package:uiproject/Widgets/home_Screen_Widegets/transaction_list.dart';
import '../Widgets/home_Screen_Widegets/balance_card.dart';
import '../Widgets/home_Screen_Widegets/home_header.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background: HomeHeader and BalanceCard (fixed)
          Column(
            children: [
             Stack(
               children: [
                 SizedBox(
                   height: mediaHeight * 0.3,
                   child:  HomeHeader(),
                 ),
                  Padding(
                   padding: EdgeInsets.only(left: 30.0,right: 30,top: mediaHeight * 0.2),
                   child: BalanceCard(),
                 ),

               ],
             ),

            ],
          ),

          // Foreground: Scrollable content
          Padding(
            padding: EdgeInsets.only(top: mediaHeight * 0.4),
            child: SingleChildScrollView(

              child: Column(

                children: [
                  Container(

                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Colors.white,
                    ),
                    child: const TransactionList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

































// import 'package:flutter/material.dart';
// import 'package:uiproject/Widgets/home_Screen_Widegets/transaction_list.dart';
//
// import '../Widgets/home_Screen_Widegets/balance_card.dart';
// import '../Widgets/home_Screen_Widegets/home_header.dart';
//
//
// class NewHomeScreen extends StatefulWidget {
//   const NewHomeScreen({super.key});
//
//   @override
//   State<NewHomeScreen> createState() => _NewHomeScreenState();
// }
//
// class _NewHomeScreenState extends State<NewHomeScreen> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return SizedBox(
//       child: Stack(
//         children: [
//           Scaffold(
//             body: SingleChildScrollView(
//               child: Stack(
//                 children:[ Container(
//                   child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           HomeHeader(),
//                           const Positioned(
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 30.0,right: 30,top: 180),
//                               child: SizedBox(
//
//                                 child: BalanceCard(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Transaction History Section
//                       SizedBox(
//                         child: Padding(
//                           padding:  EdgeInsets.symmetric(horizontal: 0),
//                           child: Container(
//                             decoration:  BoxDecoration(
//                               color:isDarkMode?Theme.of(context).scaffoldBackgroundColor : Colors.white,
//
//                             ),
//                             child:  TransactionList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 ]
//               ),
//             ),
//
//             // bottomNavigationBar:
//             //     BottomNavBar(),
// //bottomNavigationBar: BottomNavBar(),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
