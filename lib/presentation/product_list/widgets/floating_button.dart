import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  const FloatingButton({
    super.key,
    required this.showScrollToTopButton,
    required this.scrollController,
  });

  final bool showScrollToTopButton;
  final ScrollController scrollController;

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.blue).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.showScrollToTopButton ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: _scrollToTop,
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isPressed ? Colors.blue[300]! : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: FloatingActionButton(
                onPressed: null,
                backgroundColor: _colorAnimation.value,
                elevation: _isPressed ? 4 : 2,
                shape: const CircleBorder(),
                child: Icon(
                  Icons.arrow_upward,
                  color: _isPressed ? Colors.white : Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _resetButton();
  }

  void _onTapCancel() {
    _resetButton();
  }

  void _resetButton() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
