import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 30,
          child: Container(
            color: Constants.cardColor.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Hello "Username"',
                          textStyle: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          speed: const Duration(milliseconds: 100))
                    ],
                    totalRepeatCount: 2,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
