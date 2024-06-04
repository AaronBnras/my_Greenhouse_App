import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';

//
class SensorBox extends StatelessWidget {
  final String sensor;
  final String iconPath;
  final String value;

  const SensorBox(
      {super.key,
      required this.sensor,
      required this.iconPath,
      required this.value});

  Color getTextColor(String sensor, String value) {
    // Extract numerical part from the value string
    String numericalValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    // Parse the numerical part as a double
    double doubleValue = double.tryParse(numericalValue) ?? 0.0;

    // Determine text color based on the sensor and value
    switch (sensor) {
      case 'Temperature':
        return doubleValue > 30.0 ? Colors.red : Colors.green;
      case 'Humidity':
        return doubleValue > 70.0 ? Colors.red : Colors.green;
      case 'Water Level':
        return doubleValue < 50.0 ? Colors.red : Colors.green;
      case 'Soil Moisture':
        return doubleValue < 30.0 ? Colors.red : Colors.green;
      default:
        return Colors.black; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.green.shade400, width: 3),
              shape: BoxShape.rectangle
            ),
            child: Column(
              children: [

                //sensor Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding,
                          vertical: Constants.verticalPadding),
                      child: Center(
                        child: Text(
                          sensor,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // devices Icon + status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding,
                          vertical: Constants.verticalPadding),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                iconPath,
                                fit: BoxFit.contain,
                                height: 65,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      // color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1.5),
                                        child: Text(
                                          value,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w900,
                                            color: getTextColor(sensor, value)
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
                // icons
              ],
            ),
          ),
        )
      ],
    );
  }
}


