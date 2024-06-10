
import 'package:easy_buy_ar/common/common_widgets/form_header.dart';
import 'package:easy_buy_ar/common/common_widgets/social_icons.dart';
import 'package:easy_buy_ar/features/authentication/screens/login_Screen/login.dart';
import 'package:easy_buy_ar/features/authentication/screens/signup/signupFormWidget.dart';
import 'package:easy_buy_ar/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              
              children: [
                SizedBox(height: 30.0),
                FormHeaderWidget(
                  
                  title: SignupHeaderTitle,
                  
                  subtitle: SignupHeaderSubtitle,
                ),
                signupFormWidget(),
                Column(
                  children: [
                    const Text('OR'),
                    SizedBox(height: 20.0),
                    SocialIconFooter(),
                    TextButton(
                      onPressed: () => Get.to(() => const LoginScreen()),
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: 'Already have an account? ',
                              style: Theme.of(context).textTheme.bodyText1),
                          TextSpan(text: 'Login'),
                        ]),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
