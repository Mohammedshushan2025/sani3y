import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_text_field.dart';
import 'remember_forgot_row.dart';
import 'gradient_button.dart';
import 'or_divider.dart';
import 'outlined_gradient_button.dart';
import 'sign_up_row.dart';

class LoginCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool obscurePassword;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onTogglePassword;
  final VoidCallback onSignIn;
  final VoidCallback onTechnicianSignIn;
  final VoidCallback onSignUp;
  final VoidCallback onForgotPassword;
  final String technicianToggleLabel;

  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.obscurePassword,
    required this.onRememberMeChanged,
    required this.onTogglePassword,
    required this.onSignIn,
    required this.onTechnicianSignIn,
    required this.onSignUp,
    required this.onForgotPassword,
    this.technicianToggleLabel = 'دخول كصنايعي',
  }) : super(); // Default value will be overwritten by tr() in parent if needed

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 32,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Email field ──
          AppTextField(
            controller: emailController,
            label: 'email'.tr(),
            hint: 'your@email.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 18),

          // ── Password field ──
          AppTextField(
            controller: passwordController,
            label: 'password'.tr(),
            hint: '••••••••',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: obscurePassword,
            suffixIcon: obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            onSuffixTap: onTogglePassword,
          ),

          const SizedBox(height: 16),

          // ── Remember me + Forgot password ──
          RememberForgotRow(
            rememberMe: rememberMe,
            onRememberMeChanged: onRememberMeChanged,
            onForgotPassword: onForgotPassword,
          ),

          const SizedBox(height: 24),

          // ── Sign In button ──
          GradientButton(
            label: 'sign_in'.tr(),
            onTap: onSignIn,
          ),

          const SizedBox(height: 20),

          // ── OR divider ──
          const OrDivider(),

          const SizedBox(height: 20),

          // ── Sign In as Technician ──
          OutlinedGradientButton(
            label: technicianToggleLabel,
            onTap: onTechnicianSignIn,
          ),

          const SizedBox(height: 24),

          // ── Sign Up row ──
          SignUpRow(onSignUp: onSignUp),
        ],
      ),
    );
  }
}
