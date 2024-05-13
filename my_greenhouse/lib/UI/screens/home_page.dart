//import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_greenhouse/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List Of devices and Sensors

  List myDevices = [
    ['Temperature', const Icon(BoxIcons.bxs_thermometer)],
    ['Humidity', const Icon(BoxIcons.bxs_droplet)],
    ['Water Level', const Icon(BoxIcons.bxl_periscope)],
    ['Soil Moisture', const Icon(BoxIcons.bx_fast_forward)],

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
                              'monitor our greenhouse farm',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w100,
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
                            vertical: Constants.verticalPadding),
                        child: const Text(
                          'Sensor and Devices',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: GridView.builder(
                          itemCount: myDevices.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.blue,
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
