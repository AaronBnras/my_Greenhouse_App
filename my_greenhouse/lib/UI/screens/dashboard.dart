import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/models/temperature._box.dart';
import 'package:page_transition/page_transition.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final double value=100.0;
  Color getGradientColorForValue( double value){
    if (value <= 33.3) {
      return Colors.green;
    } else if (value <= 66.6) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.horizontalPadding,
                              vertical: Constants.verticalPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: Colors.green,
                                        ),
                                        child: Image.asset(
                                          'assets/images/User.png',
                                          height: 65,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Username',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 24.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sensors and Devices',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Sensor and Device Readings',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Colors.green,
                        border: Border.all(
                          color: Colors.black87,
                        )),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(context, PageTransition(child: const TemperatureBox(), type: PageTransitionType.bottomToTop)),
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
                                border: Border.all(color: Colors.black, width: 4)
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Temperature',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    AnimatedRadialGauge(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.elasticOut,
                                      radius: 120,
                                      value: value,
                                      axis: GaugeAxis(
                                        min: 0,
                                        max: 100,
                                        degrees: 260,
                                        style: const GaugeAxisStyle(
                                          thickness: 20,
                                          background: Color(0xFFDFE2EC),
                                          segmentSpacing: 4,
                                        ),
                                        progressBar: GaugeProgressBar.rounded(
                                          color: getGradientColorForValue(value),
                                        ),
                                        segments: const [
                                          GaugeSegment(
                                            from: 0,
                                            to: 33.3,
                                            color: Colors.grey,
                                            cornerRadius: Radius.circular(100),
                                          ),
                                          GaugeSegment(
                                            from: 33.3,
                                            to: 66.6,
                                            color: Colors.grey,
                                            cornerRadius:Radius.circular(100),
                                          ),
                                          GaugeSegment(
                                            from: 66.6,
                                            to: 100,
                                            color: Colors.grey,
                                            cornerRadius: Radius.circular(100),
                                          ),
                                        ],

                                      ),
                                      builder: (context, child, value) => RadialGaugeLabel(
                                        value: value,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 46,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                    ),],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.green[100],
                                          borderRadius: BorderRadius.circular(10)),
                                      height: 60,
                                      child: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(1.5),
                                            child: Text(
                                              '45%',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w900,
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
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
