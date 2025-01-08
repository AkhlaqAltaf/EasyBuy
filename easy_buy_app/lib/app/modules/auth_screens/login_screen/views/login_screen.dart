
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/custom_button.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  // Bind the controller using GetX

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
                      const SizedBox(height: 80),
                      Image.asset(
                        'assets/logo/logo.png',
                        height: 200.0,
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            Obx(() => TextFormField(
                                  controller: controller.emailController.value,
                                  decoration: const InputDecoration(
                                    label: Text("Email"),
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: controller.emailValidator,
                                )),
                            const SizedBox(height: 20),

                            // Password Field
                            Obx(() => TextFormField(
                                  controller:
                                      controller.passwordController.value,
                                  decoration: InputDecoration(
                                    label: const Text("Password"),
                                    prefixIcon: const Icon(Icons.password),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.togglePasswordVisibility();
                                      },
                                      icon: Icon(
                                        controller.isPasswordVisible.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                                  obscureText:
                                      !controller.isPasswordVisible.value,
                                  validator: controller.passwordValidator,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Button
                      Obx(() => CustomButton(
                            text: "Login",
                            onPressed: () => controller.signIn(_formKey),
                            fontSize: 16.sp,
                            radius: 50.r,
                            verticalPadding: 16.h,
                            hasShadow: false,
                            disabled: controller.isLoading.value,
                          )),
                      const SizedBox(height: 20),

                      // Signup Navigation Button
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.SIGNUP);
                          // Get.to(() => SignupScreen());
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 16),
                            children: [
                              TextSpan(
                                text: "If You have Not An Account",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(text: "   "),
                              TextSpan(
                                text: "Register",
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
