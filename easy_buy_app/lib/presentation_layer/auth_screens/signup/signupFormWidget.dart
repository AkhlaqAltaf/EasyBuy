
import 'package:easy_buy_app/presentation_layer/auth_screens/login_Screen/login.dart';
import 'package:easy_buy_app/presentation_layer/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



class signupFormWidget extends StatelessWidget {
  const signupFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            TextField(
              decoration: InputDecoration(
                label: Text(SignUpEmail),
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height:20.0),
            TextField(
              decoration: InputDecoration(
                label: Text(SignupPhone),
                prefixIcon: Icon(Icons.fingerprint),
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                label: Text(SignupPass),
                prefixIcon: Icon(Icons.fingerprint),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Sign Up".toUpperCase()),
              ),
            ),
             
    
          ],
        ),
      ),
    );
  }
}
