import 'package:easy_buy_app/apis/auth_apis/signup_api.dart';
import 'package:easy_buy_app/data_layer/auth/auth_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/custom_button.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final _formKey = GlobalKey<FormState>();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Image.asset(
                        'assets/logo/logo.png',
                        height: 200.0,
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.emailController,
                              decoration: const InputDecoration(
                                label: Text("Email"),
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: controller.emailValidator,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.passwordController,
                              decoration: InputDecoration(
                                label: const Text("Password"),
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.isVisible =
                                        !controller.isVisible;
                                  },
                                  icon: Icon(
                                    controller.isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              obscureText: !controller.isVisible,
                              validator: controller.passwordValidator,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.confirmPasswordController,
                              decoration: const InputDecoration(
                                label: Text("Confirm Password"),
                                prefixIcon: Icon(Icons.password),
                              ),
                              obscureText: controller.isVisible,
                              validator: controller.confirmPasswordValidator,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        text: "Register",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Auth auth = Auth(
                              email: controller.emailController!.text,
                              password: controller.passwordController!.text,
                            );

                            controller.isLoading = true;

                            try {
                              await registerUser(auth, context);
                            } finally {
                              controller.isLoading = false;
                            }
                          }
                        },
                        fontSize: 16.sp,
                        radius: 50.r,
                        verticalPadding: 16.h,
                        hasShadow: false,
                        disabled: controller.isLoading,
                        icon: Icon(Icons.app_registration),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.LOGIN);
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: "If You have An Account",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(text: "   "),
                              TextSpan(
                                text: "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
