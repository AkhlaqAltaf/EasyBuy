
import 'package:easy_buy_ar/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';



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
                label: Text(SignupFullName),
                prefixIcon: Icon(Icons.person_outline_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
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
                prefixIcon: Icon(Icons.numbers),
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
