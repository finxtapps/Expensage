import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/header_Color.dart';
import '../theme/theme_provider.dart';
class HeaderAppbar extends StatefulWidget {
  final String title;
  final bool back_btn;
  const HeaderAppbar({
    super.key,
    required this.title,
    this.back_btn = true,
  });

  @override
  State<HeaderAppbar> createState() => _HeaderAppbarState();
}

class _HeaderAppbarState extends State<HeaderAppbar> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: themeProvider.currentTheme == 'Pink'
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
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02,
            horizontal: 20,
          ),
          child: Row(
            children: [
              if (widget.back_btn)
                GestureDetector(
                  onTap: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.pop(context); // Pehle wali screen (MainScreenWrapper) pe chala jayega
                    }
                  },
                  child:  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              if (widget.back_btn) const SizedBox(width: 20),
              if (!widget.back_btn)  SizedBox(
                  width:MediaQuery.of(context).size.width*0.05
              ),
              Text(
                widget.title,
                style: const TextStyle(
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



















// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../theme/header_Color.dart';
// import '../theme/theme_provider.dart';
//
// class HeaderAppbar extends StatefulWidget {
//   final String title;
//   final bool back_btn;
//   const HeaderAppbar({super.key,
//   required this.title,
//     this.back_btn=true,
//   });
//
//   @override
//   State<HeaderAppbar> createState() => _HeaderAppbarState();
// }
//
// class _HeaderAppbarState extends State<HeaderAppbar> {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return  Container(
//       decoration: BoxDecoration(
//         gradient:
//         themeProvider.currentTheme == 'Pink'
//             ? HeaderColor.pinkGradient
//             : themeProvider.currentTheme == 'Green'
//             ? HeaderColor.greenGradient
//             : themeProvider.currentTheme == 'Blue'
//             ? HeaderColor.blueGradient
//             : themeProvider.currentTheme == 'Orange'
//             ? HeaderColor.orangeGradient
//             : HeaderColor.darkGradient,
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding:   EdgeInsets.symmetric(
//               vertical:MediaQuery.of(context).size.height*0.02 ,
//
//               horizontal: 20),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: widget.back_btn==false? SizedBox(height: 0,width: 0,):Icon(
//                   Icons.arrow_back,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Text(
//                 widget.title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
