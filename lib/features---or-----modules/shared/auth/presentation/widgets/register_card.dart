import 'package:clean_arc/features---or-----modules/shared/auth/presentation/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_dropdown_field.dart';
import 'app_text_field.dart';
import 'register_gradient_button.dart';
import 'sign_in_row.dart';
import 'user_type_selector.dart';

class RegisterCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final UserType selectedUserType;
  final List<Map<String, String>> categories;
  final String? selectedCategoryId;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final ValueChanged<UserType> onUserTypeChanged;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onCreateAccount;
  final VoidCallback onSignIn;

  const RegisterCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.selectedUserType,
    required this.categories,
    required this.selectedCategoryId,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onUserTypeChanged,
    required this.onCategoryChanged,
    required this.onCreateAccount,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Full Name
          AppTextField(
            controller: nameController,
            label: 'الاسم الكامل',
            hint: 'John Doe',
            prefixIcon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
          ),

          const SizedBox(height: 18),

          // Email
          AppTextField(
            controller: emailController,
            label: 'البريد الإلكتروني',
            hint: 'your@email.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 18),

          // Phone
          AppTextField(
            controller: phoneController,
            label: 'رقم الهاتف',
            hint: '+20 1XX XXX XXXX',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),

          const SizedBox(height: 18),

          // Password
          AppTextField(
            controller: passwordController,
            label: 'كلمة المرور',
            hint: '••••••••',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: obscurePassword,
            suffixIcon: obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            onSuffixTap: onTogglePassword,
          ),

          const SizedBox(height: 18),

          // Confirm Password
          AppTextField(
            controller: confirmPasswordController,
            label: 'تأكيد كلمة المرور',
            hint: '••••••••',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: obscureConfirmPassword,
            suffixIcon: obscureConfirmPassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            onSuffixTap: onToggleConfirmPassword,
          ),

          const SizedBox(height: 24),

          // User type selector
          UserTypeSelector(
            selectedType: selectedUserType,
            onChanged: onUserTypeChanged,
          ),

          if (selectedUserType == UserType.technician) ...[
            const SizedBox(height: 18),
            AppDropdownField<String>(
              label: 'القسم',
              hint: 'اختر القسم الذي تعمل به',
              prefixIcon: Icons.work_outline_rounded,
              value: selectedCategoryId,
              items: categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat['id'],
                  child: Text(cat['name'] ?? ''),
                );
              }).toList(),
              onChanged: onCategoryChanged,
            ),
          ],

          const SizedBox(height: 28),

          // Create Account button
          RegisterGradientButton(
            label: 'إنشاء حساب',
            onTap: onCreateAccount,
          ),

          const SizedBox(height: 20),

          // Sign In row
          SignInRow(onSignIn: onSignIn),
        ],
      ),
    );
  }
}
