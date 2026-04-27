import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  final Widget child;
  const SplashBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C63FF), // violet
            Color(0xFF48CAE4), // teal
            Color(0xFFFF9F43), // orange
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          const _DecorativeCircle(
            top: -60,
            left: -60,
            size: 220,
            color: Colors.white10,
          ),
          const _DecorativeCircle(
            bottom: 80,
            right: -80,
            size: 280,
            color: Colors.white10,
          ),
          const _DecorativeCircle(
            top: 120,
            right: -40,
            size: 140,
            color: Colors.white10,
          ),
          child,
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final double? top, bottom, left, right, size;
  final Color color;

  const _DecorativeCircle({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
