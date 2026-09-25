import 'package:flutter/material.dart';
import '../main.dart';

class CozyBackground extends StatelessWidget {
  final Widget child;

  const CozyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background-with-floral-field-shadow.jpg',
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}