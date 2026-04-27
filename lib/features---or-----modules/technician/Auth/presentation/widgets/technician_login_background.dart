import 'package:flutter/material.dart';

class TechnicianLoginBackground extends StatelessWidget {
  const TechnicianLoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF9F43), // Reversed order
            Color(0xFF48CAE4),
            Color(0xFF6C63FF),
          ],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: _circle(200, Colors.white10),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: _circle(260, Colors.white10),
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
