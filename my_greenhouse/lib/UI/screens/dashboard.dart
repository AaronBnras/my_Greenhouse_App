import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/data/sensor_data.dart';
import 'package:my_greenhouse/data/thingspeak_service.dart';
import 'package:my_greenhouse/models/humidity_insight.dart';
import 'package:my_greenhouse/models/soil_moisture_insight.dart';
import 'package:my_greenhouse/models/temperature._insight.dart';
import 'package:my_greenhouse/models/water_level_insight.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ThingspeakService thingSpeakService = ThingspeakService(
    channelID: '2562505', // Replace with your ThingSpeak Channel ID
    readAPIkey: 'WBTWK03HLNA3N339', // Replace with your ThingSpeak Read API Key
  );
  late Future<SensorData?> sensorDataFuture;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    sensorDataFuture = thingSpeakService.fetchData();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        sensorDataFuture = thingSpeakService.fetchData();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
                                          color: Colors.white,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.89),
                              spreadRadius: 8,
                              blurRadius: 10,
                              offset: const Offset(0, 3))
                        ],
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.green.shade400, width: 3)),
                    child: FutureBuilder<SensorData?>(
                      future: sensorDataFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text('No data available'));
                        } else {
                          final sensorData = snapshot.data!;
                          return Column(children: [
                            // Temperature Widget

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TemperatureInsight())),
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
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Temperature',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          SleekCircularSlider(
                                            appearance:
                                                CircularSliderAppearance(
                                                    customWidths:
                                                        CustomSliderWidths(
                                                            trackWidth: 4,
                                                            progressBarWidth:
                                                                20,
                                                            shadowWidth: 40),
                                                    customColors:
                                                        CustomSliderColors(
                                                            trackColor:
                                                                const Color(
                                                                    0xffef6c00),
                                                            progressBarColor:
                                                                const Color(
                                                                    0xffffb74d),
                                                            shadowColor:
                                                                const Color(
                                                                    0xffffb74d),
                                                            shadowMaxOpacity:
                                                                0.3,
                                                            //);
                                                            shadowStep: 10),
                                                    infoProperties:
                                                        InfoProperties(
                                                            bottomLabelStyle:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xff6DA100),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            bottomLabelText:
                                                                'Temp.',
                                                            mainLabelStyle:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xff6DA100),
                                                                    fontSize:
                                                                        30.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            modifier:
                                                                (double value) {
                                                              return '${sensorData.temperature}˚C';
                                                            }),
                                                    startAngle: 90,
                                                    angleRange: 360,
                                                    size: 200.0,
                                                    animationEnabled: true),
                                            min: 0,
                                            max: 100,
                                            initialValue: sensorData.temperature,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                // color: Colors.green[100],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 60,
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(1.5),
                                                  child: Text(
                                                    'Status: ${'Normal'} ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                              ),
                            ),

                            // End Temperature Widget

                            const SizedBox(
                              height: 10,
                            ),

                            //Humidity Widget
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HumidityInsight())),
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
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Humidity',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          SleekCircularSlider(
                                            appearance:
                                                CircularSliderAppearance(
                                                    customWidths:
                                                        CustomSliderWidths(
                                                            trackWidth: 4,
                                                            progressBarWidth:
                                                                20,
                                                            shadowWidth: 40),
                                                    customColors:
                                                        CustomSliderColors(
                                                            trackColor:
                                                                const Color(
                                                                    0xff0277bd),
                                                            progressBarColor:
                                                                const Color(
                                                                    0xff4FC3F7),
                                                            shadowColor:
                                                                const Color(
                                                                    0xffB2EBF2),
                                                            shadowMaxOpacity:
                                                                0.3,
                                                            //);
                                                            shadowStep: 10),
                                                    infoProperties:
                                                        InfoProperties(
                                                            bottomLabelStyle:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xff54826D),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            bottomLabelText:
                                                                'Humidity',
                                                            mainLabelStyle:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xff54826D),
                                                                    fontSize:
                                                                        30.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            modifier:
                                                                (double value) {
                                                              return '${sensorData.humidity}%';
                                                            }),
                                                    startAngle: 90,
                                                    angleRange: 360,
                                                    size: 200.0,
                                                    animationEnabled: true),
                                            min: 0,
                                            max: 100,
                                            initialValue: sensorData.humidity,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                // color: Colors.green[100],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 60,
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(1.5),
                                                  child: Text(
                                                    'Status: ${'Normal'} ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                              ),
                            ),

                            //End Humidity Widget

                            const SizedBox(
                              height: 10,
                            ),

                            //Soil Moisture Widget

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SoilMoistureInsight())),
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
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Soil Moisture',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          SleekCircularSlider(
                                            appearance:
                                                CircularSliderAppearance(
                                                    customWidths:
                                                        CustomSliderWidths(
                                                            trackWidth: 4,
                                                            progressBarWidth:
                                                                20,
                                                            shadowWidth: 40),
                                                    customColors:
                                                        CustomSliderColors(
                                                            trackColor:
                                                                const Color(
                                                                    0xff6AA84F),
                                                            progressBarColor:
                                                                const Color(
                                                                    0xff93C47D),
                                                            shadowColor:
                                                                const Color(
                                                                    0xff93C47D),
                                                            shadowMaxOpacity:
                                                                0.3,
                                                            //);
                                                            shadowStep: 10),
                                                    infoProperties:
                                                        InfoProperties(
                                                            bottomLabelStyle:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xff54826D),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            bottomLabelText:
                                                                'Soil Moisture',
                                                            mainLabelStyle:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xff54826D),
                                                                    fontSize:
                                                                        30.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            modifier:
                                                                (double value) {
                                                              return '${sensorData.soilMoisture}%';
                                                            }),
                                                    startAngle: 90,
                                                    angleRange: 360,
                                                    size: 200.0,
                                                    animationEnabled: true),
                                            min: 0,
                                            max: 100,
                                            initialValue: sensorData.soilMoisture,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                // color: Colors.green[100],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 60,
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(1.5),
                                                  child: Text(
                                                    'Status: ${'Normal'} ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                              ),
                            ),

                            //Soil Moisture Widget

                            const SizedBox(
                              height: 10,
                            ),

                            //Water Level Widget
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WaterLevelInsight())),
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
                                      border: Border.all(
                                          color: Colors.green.shade400,
                                          width: 2)),
                                  child: Column(
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Water Level',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          SleekCircularSlider(
                                            appearance:
                                                CircularSliderAppearance(
                                                    customWidths:
                                                        CustomSliderWidths(
                                                            trackWidth: 4,
                                                            progressBarWidth:
                                                                20,
                                                            shadowWidth: 40),
                                                    customColors:
                                                        CustomSliderColors(
                                                            trackColor:
                                                                const Color(
                                                                    0xff0277bd),
                                                            progressBarColor:
                                                                const Color(
                                                                    0xff4FC3F7),
                                                            shadowColor:
                                                                const Color(
                                                                    0xffB2EBF2),
                                                            shadowMaxOpacity:
                                                                0.3,
                                                            //);
                                                            shadowStep: 10),
                                                    infoProperties:
                                                        InfoProperties(
                                                            bottomLabelStyle:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xff54826D),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            bottomLabelText:
                                                                'Water Level',
                                                            mainLabelStyle:
                                                                const TextStyle(
                                                                    color: Color(
                                                                        0xff54826D),
                                                                    fontSize:
                                                                        30.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                            modifier:
                                                                (double value) {
                                                              return '${sensorData.waterLevel.toStringAsFixed(1)}%';
                                                            }),
                                                    startAngle: 90,
                                                    angleRange: 360,
                                                    size: 200.0,
                                                    animationEnabled: true),
                                            min: 0,
                                            max: 100,
                                            initialValue: sensorData.waterLevel,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                // color: Colors.green[100],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 60,
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(1.5),
                                                  child: Text(
                                                    'Status: ${'Low'} ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                              ),
                            ),

                            //End Water Level Widget

                            const SizedBox(
                              height: 10,
                            ),

                            //Fan Widget
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                    border: Border.all(
                                        color: Colors.green.shade400,
                                        width: 2)),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Fan',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/Fans.png',
                                          fit: BoxFit.contain,
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.green[100],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 60,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(1.5),
                                                child: Text(
                                                  'Status: ${'On'} ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w500,
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
                            ),

                            //End Fan Widget

                            const SizedBox(
                              height: 10,
                            ),

                            //Water Pump
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                    border: Border.all(
                                        color: Colors.green.shade400,
                                        width: 2)),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Water Pump',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/water-pump.png',
                                          fit: BoxFit.contain,
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              // color: Colors.green[100],
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 60,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(1.5),
                                                child: Text(
                                                  'Status: ${'On'} ',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w500,
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
                            ),
                          ]);
                        }
                      },
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
