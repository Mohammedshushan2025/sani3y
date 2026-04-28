import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpRow extends StatelessWidget {
  final VoidCallback onSignUp;
  const SignUpRow({super.key, required this.onSignUp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'don_t_have_account'.tr(),
          style: const TextStyle(fontSize: 13, color: Color(0xFF888888)),
        ),
        GestureDetector(
          onTap: onSignUp,
          child: Text(
            'sign_up'.tr(),
            style: const TextStyle(
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
