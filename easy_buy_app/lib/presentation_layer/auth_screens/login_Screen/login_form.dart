import 'package:easy_buy_app/presentation_layer/auth_screens/login_Screen/login.dart';
import 'package:easy_buy_app/presentation_layer/auth_screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "Email",
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      padding: EdgeInsets.all(30.0),
                      child: Text('Password reset functionality here'),
                    ),
                  );
                },
                child: Text('Forgot Password'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.7),
                ),
                child: Text('LOGIN'),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account?",
                          style: Theme.of(context).textTheme.bodyText1),
                      TextSpan(text: ' Signup'),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
