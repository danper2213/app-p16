import 'package:flutter/material.dart';

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const ShakeTransition({
    super.key,
    this.offset = 140.0,
    this.duration = const Duration(seconds: 1),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: Curves.elasticOut,
      tween: Tween(begin: 1.0, end: 0),
      builder: (context, value, child) {
        return Transform.translate(
            offset: Offset(
              value * offset,
              0.0,
            ),
            child: child);
      },
      child: child,
    );
  }
}
