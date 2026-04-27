import 'package:flutter/material.dart';

class RememberForgotRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onForgotPassword;

  const RememberForgotRow({
    super.key,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember me checkbox
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: rememberMe,
                onChanged: onRememberMeChanged,
                activeColor: const Color(0xFF6C63FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'تذكرني',
              style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
            ),
          ],
        ),
        // Forgot password
        GestureDetector(
          onTap: onForgotPassword,
          child: const Text(
            'نسيت كلمة المرور؟',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF48CAE4),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
