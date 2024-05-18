import 'package:flutter/material.dart';




class TemperatureInsight extends StatefulWidget {
  const TemperatureInsight({super.key});

  @override
  State<TemperatureInsight> createState() => _TemperatureInsightState();
}

class _TemperatureInsightState extends State<TemperatureInsight> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: const Text('Temperature',
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 24
          ),
          ),
          backgroundColor: Colors.white

          ,
        ),
      ),
    );
  }
}
