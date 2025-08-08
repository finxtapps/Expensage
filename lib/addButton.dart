import 'package:flutter/material.dart';
import 'Screens/AddTransactionScreen.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final GlobalKey _buttonKey = GlobalKey();

  void _openPopup() {
    final renderBox =
    _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: AddTransactionScreen(
            onBackPressed: () {
              Navigator.of(context).pop();
            },

          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: MediaQuery.of(context).size.width / 2 - 35,
      child: GestureDetector(
        key: _buttonKey,
        onTap: _openPopup,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }
}






















































// import 'package:flutter/material.dart';
//
// import 'Screens/AddTransactionScreen.dart';
//  // Make sure path is correct
//
// class AddButton extends StatefulWidget {
//   const AddButton({super.key});
//
//   @override
//   State<AddButton> createState() => _AddButtonState();
// }
//
// class _AddButtonState extends State<AddButton> {
//   final GlobalKey _buttonKey = GlobalKey();
//
//   void _openPopup() {
//     final renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
//     final position = renderBox.localToGlobal(Offset.zero);
//     final size = renderBox.size;
//
//     final center = Offset(
//       position.dx + size.width / 2,
//       position.dy + size.height / 2,
//     );
//
//     Navigator.of(context).push(
//       PageRouteBuilder(
//         opaque: false,
//         barrierColor: Colors.transparent,
//         transitionDuration: const Duration(milliseconds:800),
//         reverseTransitionDuration: const Duration(milliseconds: 500),
//         pageBuilder: (_, __, ___) => PopupGrowScreen(center: center),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       left: MediaQuery.of(context).size.width / 2 - 35,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(43),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(5.5),
//               child: Container(
//                 key: _buttonKey,
//                 height: 60,
//                 width: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(40),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 child: Material(
//                   color: Colors.transparent,
//                   shape: const CircleBorder(),
//                   child: InkWell(
//                     customBorder: const CircleBorder(),
//                     onTap: _openPopup,
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       decoration: BoxDecoration(
//                         /////////////////////////////////////////////
//                         color: Theme.of(context).colorScheme.primary,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(Icons.add, size: 60, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// ///////////////////////////////////////////////////////////////////////////
//
// class PopupGrowScreen extends StatefulWidget {
//   final Offset center;
//   const PopupGrowScreen({super.key, required this.center});
//
//   @override
//   State<PopupGrowScreen> createState() => _PopupGrowScreenState();
// }
//
// class _PopupGrowScreenState extends State<PopupGrowScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Rect?> _rectAnimation;
//   late Animation<double> _opacityAnimation;
//   bool _initialized = false;
//   bool _isClosing = false;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     if (_initialized) return;
//     _initialized = true;
//     final screenSize = MediaQuery.of(context).size;
//     final beginSize = const Size(70, 70);
//     final beginRect = Rect.fromCenter(
//       center: widget.center,
//       width: beginSize.width,
//       height: beginSize.height,
//     );
//     final endRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//       reverseDuration: const Duration(milliseconds: 500),
//     );
//
//     _rectAnimation = RectTween(begin: beginRect, end: endRect).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
//     );
//
//     _opacityAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.3, 1.0),
//     );
//
//     _controller.forward();
//   }
//
//   Future<void> _closePopup() async {
//     setState(() => _isClosing = true);
//     await _controller.reverse();
//     if (mounted) Navigator.of(context).pop();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_initialized || !_controller.isAnimating && !_controller.isCompleted) {
//       return const SizedBox.shrink();
//     }
//
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, __) {
//         return Stack(
//           children: [
//             IgnorePointer(
//               ignoring: _isClosing,
//               child: Opacity(
//                 opacity: _opacityAnimation.value * 0.4,
//                 child: const ModalBarrier(
//                   dismissible: false,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             Positioned.fromRect(
//               rect: _rectAnimation.value ?? Rect.zero,
//               child: Material(
//                 borderRadius: BorderRadius.circular(
//                   _controller.status == AnimationStatus.forward ? 30 : 0,
//                 ),
//                 color: Theme.of(context).colorScheme.primary,
//                 elevation: 10,
//                 child: _opacityAnimation.value > 0.8
//                     ?  AddTransactionScreen()
//                     : const SizedBox.shrink(),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }































// import 'package:flutter/material.dart';
//
// import 'Screens/AddTransactionScreen.dart';
//
// class AddButton extends StatefulWidget {
//   const AddButton({super.key});
//
//   @override
//   State<AddButton> createState() => _AddButtonState();
// }
//
// class _AddButtonState extends State<AddButton> {
//   @override
//   Widget build(BuildContext context) {
//     return  Positioned(
//       bottom: -0,
//       left: MediaQuery.of(context).size.width / 2 - 35,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(43),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 5.0,right: 5,top: 5,bottom: 5.5),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(40),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//
//                 child: SizedBox(
//                   height: 60,
//                   width: 60,
//                   child: Material(
//                     color: Colors.transparent,
//                     shape: const CircleBorder(),
//                     child: InkWell(
//                       customBorder: const CircleBorder(),
//                       onTap: () {
//
//                         final renderBox = context.findRenderObject() as RenderBox;
//                         final fabPosition = renderBox.localToGlobal(Offset.zero);
//
//                         showGeneralDialog(
//                           context: context,
//                           barrierLabel: "FABPopup",
//                           barrierDismissible: true,
//                           barrierColor: Colors.black.withOpacity(0.4),
//                           transitionDuration: const Duration(milliseconds: 2000),
//                           pageBuilder: (context, anim1, anim2) {
//                             return const SizedBox.shrink(); // Not used
//                           },
//                           transitionBuilder: (context, animation, secondaryAnimation, child) {
//                             final scale = Tween<double>(begin: 0.0, end: 1.0).animate(
//                               CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//                             );
//
//                             return Transform.scale(
//                               scale: scale.value,
//                               origin: fabPosition,
//                               child: Opacity(
//                                 opacity: animation.value,
//                                 child: AddTransactionScreen(),
//                               ),
//                             );
//                           },
//                         );
//
//
//
//                         //Navigator.pushNamed(context,'addTransaction');
//                       },
//                       child: Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).colorScheme.secondary,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.add, size: 60, color: Colors.white),
//                       ),
//                     ),
//                   ),
//
//                 ),
//
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
