import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/data/firebase_service.dart';
import 'package:my_greenhouse/data/sensor_data.dart';

class HumidityInsight extends StatefulWidget {
  const HumidityInsight({super.key});

  @override
  State<HumidityInsight> createState() => _HumidityInsightState();
}

class _HumidityInsightState extends State<HumidityInsight> {
  final FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
  }

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
          body: StreamBuilder<SensorData?>(
            stream: firebaseService.sensorDataStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No data available'));
              } else {
                final sensorData = snapshot.data!;
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                      vertical: Constants.verticalPadding),
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
                                offset: const Offset(0, 2))
                          ],
                          border: Border.all(
                              color: (sensorData.humidity <= 30 ||
                                      sensorData.humidity >= 70)
                                  ? Colors.red.shade400
                                  : Colors.green.shade400,
                              width: 3),
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(1.5),
                              child: Text(
                                'Status: ${sensorData.humidity <= 30 ? 'Low' : (sensorData.humidity >= 70 ? 'High' : 'Normal')}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: (sensorData.humidity <= 30 ||
                                          sensorData.humidity >= 70)
                                      ? Colors.red.shade400
                                      : Colors.green.shade400,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 2))
                          ],
                          border: Border.all(
                              color: (sensorData.humidity <= 30 ||
                                      sensorData.humidity >= 70)
                                  ? Colors.red.shade400
                                  : Colors.green.shade400,
                              width: 3),
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(1.5),
                              child: Text(
                                'Humidity : ${sensorData.humidity}% ',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: (sensorData.humidity <= 30 ||
                                          sensorData.humidity >= 70)
                                      ? Colors.red.shade400
                                      : Colors.green.shade400,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
