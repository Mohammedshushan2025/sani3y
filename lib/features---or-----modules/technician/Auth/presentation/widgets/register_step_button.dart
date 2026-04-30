import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_cubit.dart';
import 'package:clean_arc/features---or-----modules/technician/Auth/presentation/cubit/technician_register_state.dart';

// ════════════════════════════════════════════════
//  REGISTER STEP BUTTON
//  Same visual as GradientButton but swaps to a
//  CircularProgressIndicator during RegisterLoadingState.
// ════════════════════════════════════════════════

class RegisterStepButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const RegisterStepButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicianRegisterCubit, TechnicianRegisterState>(
      buildWhen: (prev, curr) =>
          curr is RegisterLoadingState ||
          prev is RegisterLoadingState,
      builder: (context, state) {
        final isLoading = state is RegisterLoadingState;
        return GestureDetector(
          onTap: isLoading ? null : onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 54,
            decoration: BoxDecoration(
              gradient: isLoading
                  ? const LinearGradient(
                      colors: [Color(0xFFB0AAFF), Color(0xFF9BE8F5)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF48CAE4)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: isLoading
                  ? []
                  : [
                      BoxShadow(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
