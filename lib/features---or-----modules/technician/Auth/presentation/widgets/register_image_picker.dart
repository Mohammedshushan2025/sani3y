import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_state.dart';

// ════════════════════════════════════════════════
//  REGISTER IMAGE PICKER WIDGET
//  Circular avatar with gradient camera badge.
//  Tapping opens the gallery via the cubit.
// ════════════════════════════════════════════════

class RegisterImagePicker extends StatelessWidget {
  const RegisterImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicianRegisterCubit, TechnicianRegisterState>(
      buildWhen: (prev, curr) =>
          curr is ImagePickedState || prev is ImagePickedState,
      builder: (context, state) {
        final cubit = TechnicianRegisterCubit.of(context);
        final imagePath = cubit.pickedImagePath;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Label ──
            const Text(
              'صورة الملف الشخصي',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF444444),
              ),
            ),
            const SizedBox(height: 10),
            // ── Avatar + badge ──
            GestureDetector(
              onTap: () => cubit.pickImage(),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF5F5FA),
                      border: Border.all(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
                        width: 2,
                      ),
                      image: imagePath != null
                          ? DecorationImage(
                              image: FileImage(File(imagePath)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: imagePath == null
                        ? const Icon(
                            Icons.person_outline_rounded,
                            size: 40,
                            color: Color(0xFFAAAAAA),
                          )
                        : null,
                  ),
                  // ── Gradient camera badge ──
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFF48CAE4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
