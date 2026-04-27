import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: Colors.grey.shade300, thickness: 1),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'أو',
            style: TextStyle(fontSize: 13, color: Color(0xFFAAAAAA)),
          ),
        ),
        Expanded(
          child: Divider(color: Colors.grey.shade300, thickness: 1),
        ),
      ],
    );
  }
}
