import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Image(image: AssetImage("assets/logo/logo.png")),
      ],
    );
  }
}
