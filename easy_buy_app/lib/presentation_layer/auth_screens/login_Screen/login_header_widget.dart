import 'package:flutter/material.dart';

class LoginWidgetHeader extends StatelessWidget {
  const LoginWidgetHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.2),
          Text("Welcome Back",
              style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 20),
         
        ],
      ),
    );
  }
}
