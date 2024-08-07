import 'package:flutter/material.dart';
import 'package:my_greenhouse/UI/root_page.dart';
import 'package:my_greenhouse/UI/screens/sign_up.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/UI/screens/widgets/custom_textfield.dart';
import 'package:page_transition/page_transition.dart';
import 'package:my_greenhouse/services/firebase_authentication.dart';

import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthentication _auth = FirebaseAuthentication();
  bool _isLoading = false;

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(
          color: isError ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),),

        duration: const Duration(seconds: 3),
        backgroundColor: isError ? Colors.red : Colors.white,
      ),
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please enter email and password');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signIn(email, password);
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const RootPage(),
          type: PageTransitionType.leftToRight,
        ),
      );
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('user-not-found')) {
        _showSnackBar('User not found. Please register.');
      } else if (errorMessage.contains('invalid-credential')) {
        _showSnackBar('The provided credentials are invalid. Please check and try again.');
      } else {
        _showSnackBar(errorMessage);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/signin.png'),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              customtextfield(
                obscureText: false,
                hintText: 'Enter Email',
                icon: Icons.alternate_email,
                controller: _emailController,
              ),
              customtextfield(
                obscureText: true,
                hintText: 'Enter Password',
                icon: Icons.lock,
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _isLoading ? null : _signIn,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: _isLoading
                        ? Constants.primaryColor.withOpacity(0.7)
                        : Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Center(
                    child: _isLoading
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot Password? ',
                      style: TextStyle(color: Constants.blackColor),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const ForgotPassword(),
                          type: PageTransitionType.bottomToTop,
                        ),
                      ),
                      child: Text(
                        'Reset Here',
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 20),
              // Container(
              //   width: size.width,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Constants.primaryColor),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10,
              //     vertical: 15,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       SizedBox(
              //         height: 30,
              //         child: Image.asset('assets/images/google.png'),
              //       ),
              //       Text(
              //         'Sign In with Google',
              //         style: TextStyle(
              //           color: Constants.blackColor,
              //           fontSize: 18.0,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New To My Greenhouse App? ',
                      style: TextStyle(color: Constants.blackColor),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const SignUp(),
                          type: PageTransitionType.bottomToTop,
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}