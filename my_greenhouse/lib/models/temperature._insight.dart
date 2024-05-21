import 'package:fl_chart/fl_chart.dart';
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
          body: ListView(
            children: [
              Padding(
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
                              'Temperature in Centigrade : ${20}˚C ',
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
                              'Temperature in Fahrenheit : ${90}˚F',
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
                    const SizedBox(height: 50,),
                    Center(
                        child: Container(
                          height: 500,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 2)
                                )
                              ],
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: AspectRatio(
                              aspectRatio: 2.0,
                              child: LineChart(
                                LineChartData(
                                  lineBarsData: [

                                  ]
                                )
                              ),
                            )
                        ),

                    )

                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
