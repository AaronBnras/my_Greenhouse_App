import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';

class TemperatureInsight extends StatefulWidget {
  const TemperatureInsight({super.key});

  @override
  State<TemperatureInsight> createState() => _TemperatureInsightState();
}

class _TemperatureInsightState extends State<TemperatureInsight> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.horizontalPadding, vertical: Constants.verticalPadding),
            child: Row(
              children: [
                Container(
                  color: Colors.blue,
                  child: const Column(
                    children: [
                      Row(
                        children: [

                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
