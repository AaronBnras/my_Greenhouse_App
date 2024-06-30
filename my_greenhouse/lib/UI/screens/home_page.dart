import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:my_greenhouse/UI/screens/widgets/show_popup.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/data/sensor_data.dart';
import 'package:my_greenhouse/data/firebase_service.dart';
import 'package:my_greenhouse/models/sensors_box.dart';
import 'package:my_greenhouse/utils/string_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService firebaseService = FirebaseService();
  User? _user;
  String _displayName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    setState(() {
      _displayName = _user?.displayName ?? 'No Name';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Constants.cardColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Constants.horizontalPadding,
                              vertical: Constants.verticalPadding,
                            ),
                            child: Row(
                              children: [
                                AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'Hello "${_displayName}"'.toLowerCase(),
                                      textStyle: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                  ],
                                  totalRepeatCount: 2,
                                  pause: const Duration(milliseconds: 1000),
                                  displayFullTextOnTap: true,
                                  stopPauseOnTap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding,
                          vertical: 5.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Welcome User In GreenHouse App
                            const Text(
                              'Welcome',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              _displayName.capitalize(),
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const Text(
                              'monitor your greenhouse farm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              thickness: 1,
                              color: Colors.green.shade400,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: Constants.horizontalPadding,
                      //   ),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       showPopup(context);
                      //     },
                      //     child: Container(
                      //       width: 150,
                      //       decoration: BoxDecoration(
                      //         color: Colors.green.shade400,
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 10,
                      //         vertical: 20,
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           'Setup Device',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 18.0,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Row(
                      //     children: <Widget>[
                      //       const Expanded(
                      //         child: TextField(
                      //           // controller: _controller,
                      //           decoration: InputDecoration(
                      //             labelText: 'Enter System ID',
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(width: 8),
                      //       ElevatedButton(
                      //         onPressed: () {},
                      //         child: const Text('Connect'),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding,
                        ),
                        child: const Text(
                          'Sensors',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<SensorData?>(
                        stream: firebaseService.sensorDataStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return const Center(
                                child: Text('No data available'));
                          } else {
                            final sensorData = snapshot.data!;
                            List<List<dynamic>> myDevices = [
                              [
                                'Temperature',
                                'assets/images/temperature.png',
                                '${sensorData.temperatureC.toStringAsFixed(1)}°C'
                              ],
                              [
                                'Humidity',
                                'assets/images/humidity.png',
                                '${sensorData.humidity}%'
                              ],
                              [
                                'Water Level',
                                'assets/images/water-tanks.png',
                                '${sensorData.waterLevel.toStringAsFixed(1)}%'
                              ],
                              [
                                'Soil Moisture',
                                'assets/images/Soil.png',
                                '${sensorData.soilMoisture}%'
                              ],
                            ];
                            return SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height * 0.6,
                                  maxHeight: double.infinity,
                                ),
                                child: GridView.builder(
                                  itemCount: myDevices.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 11 / 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: SensorBox(
                                        sensor: myDevices[index][0],
                                        iconPath: myDevices[index][1],
                                        value: myDevices[index][2],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
