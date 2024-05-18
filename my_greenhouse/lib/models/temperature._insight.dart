import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';

class TemperatureInsight extends StatefulWidget {
  const TemperatureInsight({super.key});

  @override
  State<TemperatureInsight> createState() => _TemperatureInsightState();
}

class _TemperatureInsightState extends State<TemperatureInsight> {
  // double _scale = 1.0;
  //
  // void _handleTap() {
  //   setState(() {
  //     _scale = 0.8; // Scale down on tap
  //   });
  //   Future.delayed(const Duration(milliseconds: 200), () {
  //     setState(() {
  //       _scale = 1.0; // Scale back to original
  //     });
  //     Navigator.pushReplacement(context, PageTransition(child: const RootPage(), type: PageTransitionType.bottomToTop));
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                  vertical: Constants.verticalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Temperature',
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ],
              )),
          backgroundColor: Colors.white,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context as BuildContext);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Tap here to go back',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
