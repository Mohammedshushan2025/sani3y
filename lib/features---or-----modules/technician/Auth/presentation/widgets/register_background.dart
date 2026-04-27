import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  REGISTER BACKGROUND — matches LoginBackground
// ════════════════════════════════════════════════

class RegisterBackground extends StatelessWidget {
  const RegisterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF9F43), // Reversed for technician
            Color(0xFF48CAE4),
            Color(0xFF6C63FF),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
            child: _circle(220, Colors.white10),
          ),
          Positioned(
            top: 140,
            left: -40,
            child: _circle(120, Colors.white10),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: _circle(280, Colors.white10),
          ),
          Positioned(
            bottom: 100,
            right: -30,
            child: _circle(100, Colors.white10),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}
