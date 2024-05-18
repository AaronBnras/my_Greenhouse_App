import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';


class HumidityInsight extends StatefulWidget {
  const HumidityInsight({super.key});

  @override
  State<HumidityInsight> createState() => _HumidityInsightState();
}

class _HumidityInsightState extends State<HumidityInsight> {
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
                    'Humidity',
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
                    color: Colors.blue,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(1.5),
                          child: Text(
                            'Status : ${'Normal'} ',
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
                    color: Colors.blue,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(1.5),
                          child: Text(
                            'Humidity : ${20}˚C ',
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
                  // Container(
                  //   color: Colors.blue,
                  //   child: const Row(
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.all(1.5),
                  //         child: Text(
                  //           'Humidity in Fahrenheit: ${90}˚F',
                  //           overflow: TextOverflow.ellipsis,
                  //           style: TextStyle(
                  //             fontSize: 20.0,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                ],
              ),
            )
        ),
      ),
    );
  }
}
