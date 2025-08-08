













import 'package:flutter/material.dart';
import '../Screens/AddTransactionScreen.dart';

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

    final center = Offset(
      position.dx + size.width / 2,
      position.dy + size.height / 2,
    );

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 10),
        pageBuilder: (_, __, ___) => PopupGrowScreen(center: center),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: MediaQuery.of(context).size.width / 2 - 35,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.5),
            child: Container(
              key: _buttonKey,
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _openPopup,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 60, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
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
  bool _initialized = false;
  bool _isClosing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;
    _initialized = true;

    final screenSize = MediaQuery.of(context).size;
    final beginSize = const Size(70, 70);
    final beginRect = Rect.fromCenter(
      center: widget.center,
      width: beginSize.width,
      height: beginSize.height,
    );
    final endRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), //1500
      reverseDuration: const Duration(milliseconds: 700),
    );

    _rectAnimation = RectTween(begin: beginRect, end: endRect).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
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
    if (!_initialized ||
        (!_controller.isAnimating && !_controller.isCompleted)) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Stack(
          children: [
            IgnorePointer(
              ignoring: _isClosing,
              child: const ModalBarrier(
                dismissible: false,
                color: Colors.black54,
              ),
            ),
            Positioned.fromRect(
              rect: _rectAnimation.value ?? Rect.zero,
              child: Material(
                borderRadius: BorderRadius.circular(
                  _controller.status == AnimationStatus.forward ? 30 : 0,
                ),
                color: Colors.transparent,
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //
                    //     Colors.transparent,
                    //     Colors.transparent
                    //   ],
                    // ),
                    borderRadius: BorderRadius.circular(
                      _controller.status == AnimationStatus.forward ? 30 : 0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      _controller.status == AnimationStatus.forward ? 30 : 0,
                    ),
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.3, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Curves.easeInOutBack,
                        ),
                      ),
                      child: AddTransactionScreen(onBackPressed: _closePopup),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
