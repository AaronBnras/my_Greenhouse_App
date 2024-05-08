import 'package:flutter/material.dart';
import 'package:my_greenhouse/UI/screens/widgets/custom_Textfield.dart';
import 'package:my_greenhouse/constants.dart';

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
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const customtextfield(
                      icon: Icons.alternate_email,
                      obscureText: false,
                      hintText: 'Enter Email'
                  ),
                  const customtextfield(
                      icon: Icons.person,
                      obscureText: false,
                      hintText: 'Enter Full Name'
                  ),
                  const customtextfield(
                      icon: Icons.lock,
                      obscureText: false,
                      hintText: 'Enter Password'
                  ),
                  const customtextfield(
                      icon: Icons.lock,
                      obscureText: false,
                      hintText: 'Confirm Password'
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Constants.primaryColor
                      ),
                    ),
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
