import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';

class WaterLevelInsight extends StatefulWidget {
  const WaterLevelInsight({super.key});

  @override
  State<WaterLevelInsight> createState() => _WaterLevelInsightState();
}

class _WaterLevelInsightState extends State<WaterLevelInsight> {
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
                    'Water Level',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 2)
                        )
                      ],
                      border: Border.all(
                          color: Colors.green.shade400,
                          width: 3
                      ),
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(1.5),
                          child: Text(
                            'Status : ${'Full'} ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 2)
                        )
                      ],
                      border: Border.all(
                          color: Colors.green.shade400,
                          width: 3
                      ),
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(1.5),
                          child: Text(
                            'Water Level : ${20}% ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                ],
              ),
            )
        ),
      ),
    );
  }
}
