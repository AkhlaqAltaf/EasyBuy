import 'package:easy_buy_ar/common/common_widgets/social_icons.dart';
import 'package:easy_buy_ar/features/authentication/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Continue With'),
        const SizedBox(height: 30.0),
        SocialIconFooter(),
        const SizedBox(height: 10.0),
        TextButton(
          onPressed: () => Get.to(() => const SignupScreen()),
          child: const Text.rich(
            TextSpan(
              text: "Don't Have an Account? ",
              children: [
                TextSpan(
                  text: 'SignUp',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
