import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Image.asset('assets/Images/signup.png'),
                  const Text(
                    'Sign Up',
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.w700),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
