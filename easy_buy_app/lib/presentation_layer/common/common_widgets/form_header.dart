import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
   
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.2),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
       
      ],
    );
  }
}
