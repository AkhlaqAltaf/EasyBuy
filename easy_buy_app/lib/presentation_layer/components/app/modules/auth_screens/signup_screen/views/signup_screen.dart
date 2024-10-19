import 'package:easy_buy_app/apis/auth_apis/signup_api.dart';
import 'package:easy_buy_app/data_layer/auth/auth_model.dart';
import 'package:easy_buy_app/presentation_layer/components/app/modules/auth_screens/signup_screen/controllers/signup_controller.dart';
import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      SizedBox(
                        height: 80,
                      ),
                      Image.asset(
                        'assets/logo/logo.png',
                        height: 200.0,
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                label: Text("Email"),
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: controller.emailValidator,
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: controller.passwordController,
                              decoration: InputDecoration(
                                label: Text("Password"),
                                prefixIcon: Icon(Icons.password),
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
                            SizedBox(height: 20),
                            TextFormField(
                              controller: controller.confirmPasswordController,
                              decoration: InputDecoration(
                                label: Text("Confirm Password"),
                                prefixIcon: Icon(Icons.password),
                              ),
                              obscureText: controller.isVisible,
                              validator: controller.confirmPasswordValidator,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Auth auth = Auth(
                              email: controller.emailController!.text,
                              password: controller.passwordController!.text,
                            );

                            controller.isLoading = true;

                            try {
                              await registerUser(auth, context);
                            } catch (e) {
                            } finally {
                              controller.isLoading = false;
                            }
                          }
                        },
                        child: controller.isLoading
                            ? CircularProgressIndicator()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.app_registration,
                                    size: 25,
                                  ),
                                  Text(
                                    'Register',
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.LOGIN);
                        },
                        child: RichText(
                          text: TextSpan(
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
