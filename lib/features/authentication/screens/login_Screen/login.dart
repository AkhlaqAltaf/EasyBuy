import 'package:easy_buy_ar/features/authentication/screens/login_Screen/login_footer_widget.dart';
import 'package:flutter/material.dart';
import 'login_form.dart';
import 'login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginWidgetHeader(size: size),
                const LoginForm(),
                SizedBox(height: 20.0),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



