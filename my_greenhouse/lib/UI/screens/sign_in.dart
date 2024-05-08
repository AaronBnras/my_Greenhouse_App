import 'package:flutter/material.dart';
import 'package:my_greenhouse/UI/root-page.dart';
import 'package:my_greenhouse/UI/screens/sign_up.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/UI/screens/widgets/custom_textfield.dart';
import 'package:page_transition/page_transition.dart';

import 'forgot_password.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Image.asset('assets/images/signin.png'),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const customtextfield(
                    obscureText: false,
                    hintText: 'Enter Email',
                    icon: Icons.alternate_email,
                  ),
                  const customtextfield(
                    obscureText: true,
                    hintText: 'Enter Password',
                    icon: Icons.lock,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const rootpage()));
                    },
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'Forgot Password? ',
                              style: TextStyle(color: Constants.blackColor))
                        ])),
                        GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: const ForgotPassword(),
                                    type: PageTransitionType.bottomToTop)),
                            child: Center(
                                child: Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: 'Reset Here',
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ]))))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Constants.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Image.asset('assets/images/google.png'),
                        ),
                        Text(
                          'Sign In with Google',
                          style: TextStyle(
                              color: Constants.blackColor, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'New To My Greenhouse App? ',
                            style: TextStyle(color: Constants.blackColor))
                      ])),
                      GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const SignUp(),
                                  type: PageTransitionType.bottomToTop)),
                          child: Center(
                              child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ))
                          ]))))
                    ],
                  ))
                ],
              ),
            ),
          ]),
    )));
  }
}
