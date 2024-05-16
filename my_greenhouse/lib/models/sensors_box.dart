import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';

//
class SensorBox extends StatelessWidget {
  final String sensor;
  final String iconPath;
  final String status;

  const SensorBox(
      {super.key,
      required this.sensor,
      required this.iconPath,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              )
              // icons

              // devices name + status
            ],
          ),
        ),
      ),
    );
  }
}
