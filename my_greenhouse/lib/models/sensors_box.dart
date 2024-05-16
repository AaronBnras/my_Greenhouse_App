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
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                              height: 80,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration:
                                  BoxDecoration(
                                    // color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1.5),
                                    child: Text(
                                      status,
                                      style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )
                          ],
                        ),
                      ],
                    ),
                  )
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
