import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    required this.subtitle,
    required this.title,
    super.key,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.03),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        SizedBox(height: 20.0),
        Text(subtitle, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
