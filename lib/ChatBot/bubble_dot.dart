import 'package:flutter/material.dart';

class BubbleDot extends StatelessWidget {
  const BubbleDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}