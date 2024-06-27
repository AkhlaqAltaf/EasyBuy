
import 'package:easy_buy_app/presentation_layer/common/common_widgets/form_header.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/social_icons.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/login_Screen/login.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/signup/signupFormWidget.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/text_strings.dart';
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
                
                FormHeaderWidget(
                  
                  title: SignupHeaderTitle,
                  
                
                ),
                SizedBox(height: 20.0),
                signupFormWidget(),
                Column(
                  children: [
                   
                    TextButton(
                      onPressed: () => Get.to(() => const LoginScreen()),
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account?",
                              style: Theme.of(context).textTheme.bodyText1),
                          TextSpan(text: ' Login'),
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
