import 'package:easy_buy_app/apis/auth_apis/signin_api.dart';
import 'package:easy_buy_app/data_layer/auth/auth_model.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/signup_screen/signup_screen.dart';
import 'package:easy_buy_app/presentation_layer/common/common_widgets/appbar/home_appbar_Widget.dart';
import 'package:easy_buy_app/presentation_layer/components/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool isVisibale = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

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
                              controller: emailController,
                              decoration: const InputDecoration(
                                label: Text("Email"),
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: _emailValidator,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                label: const Text("Password"),
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisibale = !isVisibale;
                                    });
                                  },
                                  icon: Icon(
                                    isVisibale
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                              obscureText: !isVisibale,
                              validator: _passwordValidator,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Auth model = Auth(
                              email: emailController!.text,
                              password: passwordController!.text,
                            );
                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              await signInUser(model, context);
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    size: 25,
                                  ),
                                  Text(
                                    'Login',
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed(Routes.SIGNUP);
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
