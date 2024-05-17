import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_greenhouse/constants.dart';
import 'package:my_greenhouse/models/sensors_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List Of devices and Sensors

  List myDevices = [
    ['Temperature', 'assets/images/temperature.png', '45%' ],
    ['Humidity', 'assets/images/humidity.png', '75%'],
    ['Water Level', 'assets/images/water-tanks.png', '50%'],
    ['Soil Moisture', 'assets/images/Soil.png', '30%'],
  ];
  @override
  Widget build(BuildContext context) {
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
                            borderRadius: BorderRadius.circular(20.0)),
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Constants.cardColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.horizontalPadding,
                                vertical: Constants.verticalPadding),
                            child: Row(
                              children: [
                                AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText('Hello "Username"',
                                        textStyle: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        speed:
                                            const Duration(milliseconds: 100))
                                  ],
                                  totalRepeatCount: 2,
                                  pause: const Duration(milliseconds: 1000),
                                  displayFullTextOnTap: true,
                                  stopPauseOnTap: true,
                                )
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
                            const Text(
                              'Aaron Maeda',
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
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: GridView.builder(
                          itemCount: myDevices.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 11/10
                              ),
                          itemBuilder: (context, index) {
                            return  Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SensorBox(
                                sensor: myDevices[index][0],
                                iconPath: myDevices[index][1],
                                status: myDevices[index][2],
                              ),
                            );
                          },
                        ),
                      )
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
