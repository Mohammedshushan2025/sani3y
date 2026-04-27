import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  TECHNICIAN HOME VIEW — Placeholder
// ════════════════════════════════════════════════

class TechnicianHomeView extends StatelessWidget {
  const TechnicianHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6C63FF),
              Color(0xFF48CAE4),
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.engineering_rounded,
                  size: 80, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'مرحباً بك في صنايعي!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'قريباً — الصفحة الرئيسية للصنايعي',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
