import 'package:flutter/material.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'صنايعي',
      style: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: 1.5,
        shadows: [
          Shadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
