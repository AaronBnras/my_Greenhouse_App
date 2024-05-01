import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';

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
           const Text('Sign In', style: TextStyle(
             fontSize: 35.0,
             fontWeight: FontWeight.w700,
           ),),
           const SizedBox(
             height: 30,
           ),
           TextField(
             obscureText: false,
             style: TextStyle(
               color: Constants.blackColor,
             ),
             decoration: InputDecoration(
               border: InputBorder.none,
               prefixIcon: Icon(Icons.alternate_email, color: Constants.blackColor.withOpacity(.3),),
               hintText: "Enter Username",
             ),
             cursorColor: Constants.blackColor.withOpacity(.5),
           ),
           TextField(
             obscureText: false,
             style: TextStyle(
               color: Constants.blackColor,
             ),
             decoration: InputDecoration(
               border: InputBorder.none,
               prefixIcon: Icon(Icons.alternate_email, color: Constants.blackColor.withOpacity(.3),),
               hintText: "Enter Username",
             ),
             cursorColor: Constants.blackColor.withOpacity(.5),
           )
         ],
       ),
      ),
    );
  }
}