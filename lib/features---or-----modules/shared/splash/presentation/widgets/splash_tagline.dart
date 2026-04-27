import 'package:flutter/material.dart';

class SplashTagline extends StatelessWidget {
  const SplashTagline({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'احجز خدمات منزلية بسهولة',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white70,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
    );
  }
}
