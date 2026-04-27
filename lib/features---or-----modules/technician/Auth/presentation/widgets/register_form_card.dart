import 'package:flutter/material.dart';
import 'package:clean_arc/features---or-----modules/shared/auth/presentation/widgets/app_text_field.dart';
import 'register_dropdown_field.dart';
import 'register_image_picker.dart';
import 'register_step_button.dart';

// ════════════════════════════════════════════════
//  REGISTER FORM CARD
//  White rounded card containing all form fields.
// ════════════════════════════════════════════════

class RegisterFormCard extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController governorateController;
  final TextEditingController cityController;
  final TextEditingController ageController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  final int? selectedCategoryId;
  final ValueChanged<int?> onCategoryChanged;
  final VoidCallback onSubmit;
  final Map<String, String?> fieldErrors;

  const RegisterFormCard({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.governorateController,
    required this.cityController,
    required this.ageController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.selectedCategoryId,
    required this.onCategoryChanged,
    required this.onSubmit,
    required this.fieldErrors,
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
          // ── Profile image ──
          const Center(child: RegisterImagePicker()),

          const SizedBox(height: 24),

          // ── Full name ──
          AppTextField(
            controller: fullNameController,
            label: 'الاسم الكامل',
            hint: 'محمد أحمد',
            prefixIcon: Icons.person_outline_rounded,
          ),
          _errorText(fieldErrors['fullName']),

          const SizedBox(height: 16),

          // ── Email ──
          AppTextField(
            controller: emailController,
            label: 'البريد الإلكتروني',
            hint: 'your@email.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          _errorText(fieldErrors['email']),

          const SizedBox(height: 16),

          // ── Password ──
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
          _errorText(fieldErrors['password']),

          const SizedBox(height: 16),

          // ── Phone ──
          AppTextField(
            controller: phoneController,
            label: 'رقم الهاتف',
            hint: '01XXXXXXXXX',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          _errorText(fieldErrors['phone']),

          const SizedBox(height: 16),

          // ── Governorate ──
          AppTextField(
            controller: governorateController,
            label: 'المحافظة',
            hint: 'القاهرة',
            prefixIcon: Icons.location_city_outlined,
          ),
          _errorText(fieldErrors['governorate']),

          const SizedBox(height: 16),

          // ── City ──
          AppTextField(
            controller: cityController,
            label: 'المدينة / المنطقة',
            hint: 'مدينة نصر',
            prefixIcon: Icons.map_outlined,
          ),
          _errorText(fieldErrors['city']),

          const SizedBox(height: 16),

          // ── Age ──
          AppTextField(
            controller: ageController,
            label: 'العمر',
            hint: '25',
            prefixIcon: Icons.cake_outlined,
            keyboardType: TextInputType.number,
          ),
          _errorText(fieldErrors['age']),

          const SizedBox(height: 16),

          // ── Category dropdown ──
          RegisterDropdownField(
            selectedCategoryId: selectedCategoryId,
            onChanged: onCategoryChanged,
          ),
          _errorText(fieldErrors['category']),

          const SizedBox(height: 28),

          // ── Submit button ──
          RegisterStepButton(
            label: 'إنشاء الحساب',
            onTap: onSubmit,
          ),
        ],
      ),
    );
  }

  Widget _errorText(String? error) {
    if (error == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4, right: 4),
      child: Text(
        error,
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
