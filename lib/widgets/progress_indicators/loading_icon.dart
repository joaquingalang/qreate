import 'package:flutter/material.dart';

class LoadingIcon extends StatefulWidget {
  const LoadingIcon({super.key, required this.icon, this.isStopped = false});

  final Icon icon;
  final bool isStopped;

  @override
  State<LoadingIcon> createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void didUpdateWidget(covariant LoadingIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isStopped) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.1416, // Full Circle (Radians)
            child: widget.icon,
          );
        },
      ),
    );
  }
}
