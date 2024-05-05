import 'package:flutter/material.dart';
import 'package:my_greenhouse/UI/root-page.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/UI/screens/widgets/custom_textfield.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const rootpage()));
              },
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const rootpage()));
              },
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
            )
          ],
        ),
      ),
    );
  }
}
