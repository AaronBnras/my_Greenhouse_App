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
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                  vertical: Constants.verticalPadding),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Constants.cardColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.horizontalPadding,
                            vertical: Constants.verticalPadding),
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
                              totalRepeatCount: 4,
                              pause: const Duration(milliseconds: 1000),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                      vertical: 5.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome'),
                        const Text(
                          'Aaron Maeda',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text(
                          'monitor our greenhouse farm',
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          thickness: 1,
                          color: Colors.green.shade400,
                        ),
                        const SizedBox(height: 10), // Add some space after the divider
                        const Text(
                          'Sensor Devices',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
