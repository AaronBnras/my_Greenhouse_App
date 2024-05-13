import 'package:flutter/material.dart';
//
class SensorBox extends StatelessWidget {
  final String Sensor;
  final String iconPath;
  final bool Status;

  const SensorBox({
    super.key,
    required this.Sensor,
    required this.iconPath,
    required this.Status
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(24)
        ),
        child:  Column(
          children: [
            // icons
            Image.asset(iconPath, height: 65,),

            // devices name + status
          ],
        ),
      ),
    );
  }
}


