import 'package:flutter/material.dart';

class SignUpRow extends StatelessWidget {
  final VoidCallback onSignUp;
  const SignUpRow({super.key, required this.onSignUp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'ليس لديك حساب؟ ',
          style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
        ),
        GestureDetector(
          onTap: onSignUp,
          child: const Text(
            'إنشاء حساب',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6C63FF),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
