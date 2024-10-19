import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_buy_app/presentation_layer/components/app/modules/auth_screens/login_screen/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

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
                      SizedBox(height: 80),
                      Image.asset(
                        'assets/logo/logo.png',
                        height: 200.0,
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Field
                            Obx(() => TextFormField(
                                  controller: controller.emailController.value,
                                  decoration: InputDecoration(
                                    label: Text("Email"),
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: controller.emailValidator,
                                )),
                            SizedBox(height: 20),

                            // Password Field
                            Obx(() => TextFormField(
                                  controller:
                                      controller.passwordController.value,
                                  decoration: InputDecoration(
                                    label: Text("Password"),
                                    prefixIcon: Icon(Icons.password),
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
                      SizedBox(height: 20),

                      // Login Button
                      Obx(() => ElevatedButton(
                            onPressed: () => controller.signIn(_formKey),
                            child: controller.isLoading.value
                                ? CircularProgressIndicator()
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.login, size: 25),
                                      Text('Login'),
                                    ],
                                  ),
                          )),
                      SizedBox(height: 20),

                      // Signup Navigation Button
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.SIGNUP);
                          // Get.to(() => SignupScreen());
                        },
                        child: RichText(
                          text: TextSpan(
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
