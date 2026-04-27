import 'package:flutter/material.dart';

class SignInRow extends StatelessWidget {
  final VoidCallback onSignIn;
  const SignInRow({super.key, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'لديك حساب بالفعل؟ ',
          style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
        ),
        GestureDetector(
          onTap: onSignIn,
          child: const Text(
            'تسجيل الدخول',
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
