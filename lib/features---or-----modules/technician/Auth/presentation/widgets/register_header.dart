import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
        Text(
          'register_title'.tr(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        // ── Subtitle ──
        Text(
          'register_subtitle'.tr(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
