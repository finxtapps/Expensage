import 'package:flutter/material.dart';

class FabPopupFromButton extends StatefulWidget {
  const FabPopupFromButton({super.key});

  @override
  State<FabPopupFromButton> createState() => _FabPopupFromButtonState();
}

class _FabPopupFromButtonState extends State<FabPopupFromButton> {
  final GlobalKey _fabKey = GlobalKey();

  void _openPopup() {
    final renderBox = _fabKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final center = Offset(
      position.dx + size.width / 2,
      position.dy + size.height / 2,
    );

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(microseconds: 10),
        reverseTransitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (_, __, ___) => PopupGrowScreen(center: center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FAB Popup From Button")),
      body: const Center(child: Text("Main Screen")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        onPressed: _openPopup,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PopupGrowScreen extends StatefulWidget {
  final Offset center;
  const PopupGrowScreen({super.key, required this.center});

  @override
  State<PopupGrowScreen> createState() => _PopupGrowScreenState();
}

class _PopupGrowScreenState extends State<PopupGrowScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Rect?> _rectAnimation;
  late Animation<double> _opacityAnimation;
  bool _initialized = false;
  bool _isClosing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;
    _initialized = true;

    final screenSize = MediaQuery.of(context).size;

    final beginSize = const Size(70, 70); // Starting size near FAB
    final beginRect = Rect.fromCenter(
      center: widget.center,
      width: beginSize.width,
      height: beginSize.height,
    );

    final endRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 100),
    );

    _rectAnimation = RectTween(begin: beginRect, end: endRect).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0),
    );

    _controller.forward();
  }

  Future<void> _closePopup() async {
    setState(() => _isClosing = true);
    await _controller.reverse();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized || !_controller.isAnimating && !_controller.isCompleted) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Stack(
          children: [
            // Background overlay
            IgnorePointer(
              ignoring: _isClosing,
              child: Opacity(
                opacity: _opacityAnimation.value * 0.4,
                child: const ModalBarrier(
                  dismissible: false,
                  color: Colors.black,
                ),
              ),
            ),

            // Expanding popup container
            Positioned.fromRect(
              rect: _rectAnimation.value ?? Rect.zero,
              child: Material(
                borderRadius: BorderRadius.circular(
                  _controller.status == AnimationStatus.forward ? 30 : 0,
                ),
                color: Colors.purple.shade100, // Change color as needed
                elevation: 10,
                child: _opacityAnimation.value > 0.8
                    ? _buildPopupContent(context)
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPopupContent(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text("Popup Content"),
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(icon: const Icon(Icons.close), onPressed: _closePopup),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              "This screen popped from the FAB!",
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
//
// class FabPopupFromButton extends StatefulWidget {
//   const FabPopupFromButton({super.key});
//
//   @override
//   State<FabPopupFromButton> createState() => _FabPopupFromButtonState();
// }
//
// class _FabPopupFromButtonState extends State<FabPopupFromButton> {
//   final GlobalKey _fabKey = GlobalKey();
//
//   void _openPopup() {
//     final renderBox = _fabKey.currentContext!.findRenderObject() as RenderBox;
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
//         transitionDuration: const Duration(milliseconds: 500),
//         reverseTransitionDuration: const Duration(milliseconds: 300),
//         pageBuilder: (_, __, ___) => PopupGrowScreen(center: center),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("FAB Popup From Button")),
//       body: const Center(child: Text("Main Screen")),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         key: _fabKey,
//         onPressed: _openPopup,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
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
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//       reverseDuration: const Duration(milliseconds: 400),
//     );
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     final screenSize = MediaQuery.of(context).size;
//
//     final beginSize = const Size(70, 70); // FAB size
//     final beginRect = Rect.fromCenter(
//       center: widget.center,
//       width: beginSize.width,
//       height: beginSize.height,
//     );
//     final endRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
//
//     _rectAnimation = RectTween(
//       begin: beginRect,
//       end: endRect,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
//
//     _opacityAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: const Interval(0.3, 1.0),
//     );
//
//     _controller.forward();
//   }
//
//   void _closePopup() async {
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
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (_, __) {
//         return Stack(
//           children: [
//             // Overlay background
//             Opacity(
//               opacity: _opacityAnimation.value * 0.4,
//               child: const ModalBarrier(
//                 dismissible: false,
//                 color: Colors.black,
//               ),
//             ),
//
//             // Expanding popup container
//             Positioned.fromRect(
//               rect: _rectAnimation.value!,
//               child: Material(
//                 borderRadius: BorderRadius.circular(
//                   _controller.status == AnimationStatus.forward ? 30 : 0,
//                 ),
//                 color: Colors.deepPurple.shade100, // Custom color
//                 elevation: 10,
//                 child: _opacityAnimation.value > 0.8
//                     ? _buildPopupContent()
//                     : const SizedBox.shrink(),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildPopupContent() {
//     return Column(
//       children: [
//         AppBar(
//           title: const Text("Popup Content"),
//           backgroundColor: Colors.deepPurple,
//           automaticallyImplyLeading: false,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: _closePopup,
//             ),
//           ],
//         ),
//         const Expanded(
//           child: Center(
//             child: Text(
//               "This screen popped from the FAB!",
//               style: TextStyle(fontSize: 22),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
//
//
// class FABPopupDemo extends StatelessWidget {
//   const FABPopupDemo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('FAB Popup Animation')),
//       body: const Center(child: Text('Main Screen')),
//       floatingActionButton: Builder(
//         builder: (context) {
//           return FloatingActionButton(
//             onPressed: () {
//               final renderBox = context.findRenderObject() as RenderBox;
//               final fabPosition = renderBox.localToGlobal(Offset.zero);
//
//               showGeneralDialog(
//                 context: context,
//                 barrierLabel: "FABPopup",
//                 barrierDismissible: true,
//                 barrierColor: Colors.black.withOpacity(0.4),
//                 transitionDuration: const Duration(milliseconds: 500),
//                 pageBuilder: (context, anim1, anim2) {
//                   return const SizedBox.shrink(); // Not used
//                 },
//                 transitionBuilder: (context, animation, secondaryAnimation, child) {
//                   final scale = Tween<double>(begin: 0.0, end: 1.0).animate(
//                     CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//                   );
//
//                   return Transform.scale(
//                     scale: scale.value,
//                     origin: fabPosition,
//                     child: Opacity(
//                       opacity: animation.value,
//                       child: const _PopupContent(),
//                     ),
//                   );
//                 },
//               );
//             },
//             child: const Icon(Icons.add),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _PopupContent extends StatelessWidget {
//   const _PopupContent();
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Material(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         elevation: 10,
//         child: SizedBox(
//           width: 300,
//           height: 400,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Popup Screen',
//                 style: TextStyle(fontSize: 24),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('Close'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
