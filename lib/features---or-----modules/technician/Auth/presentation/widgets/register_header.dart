import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  REGISTER HEADER — mirrors LoginHeader style
// ════════════════════════════════════════════════

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Icon badge ──
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.engineering_rounded,
            size: 40,
            color: Color(0xFF6C63FF),
          ),
        ),
        const SizedBox(height: 20),
        // ── Title ──
        const Text(
          'انضم كصنايعي!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        // ── Subtitle ──
        const Text(
          'أنشئ حسابك وابدأ استقبال الطلبات',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
