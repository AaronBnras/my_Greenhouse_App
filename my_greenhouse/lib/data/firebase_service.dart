import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:my_greenhouse/data/sensor_data.dart';
import 'package:fl_chart/fl_chart.dart';

enum TimeUnit { second, minute, hour, day, week }

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  final DatabaseReference sensorDataRef =
  FirebaseDatabase.instance.ref().child('sensorData');
  final DatabaseReference statusRef =
  FirebaseDatabase.instance.ref().child('status');

  // New data persistence
  Map<TimeUnit, List<FlSpot>> temperatureDataPoints = {
    for (var unit in TimeUnit.values) unit: []
  };
  Map<TimeUnit, List<FlSpot>> humidityDataPoints = {
    for (var unit in TimeUnit.values) unit: []
  };
  Map<TimeUnit, List<FlSpot>> soilMoistureDataPoints = {
    for (var unit in TimeUnit.values) unit: []
  };
  Map<TimeUnit, List<FlSpot>> waterLevelDataPoints = {
    for (var unit in TimeUnit.values) unit: []
  };
  final Map<TimeUnit, DateTime> lastUpdateTime = {
    for (var unit in TimeUnit.values) unit: DateTime.now()
  };

  Stream<SensorData?> get sensorDataStream {
    if (kDebugMode) {
      print('Fetching sensor data stream...');
    }

    return sensorDataRef.onValue.asyncMap((sensorEvent) async {
      if (kDebugMode) {
        print('Received sensor event: $sensorEvent');
      }

      final sensorSnapshot = sensorEvent.snapshot;
      if (sensorSnapshot.exists && sensorSnapshot.value != null) {
        final sensorData = Map<String, dynamic>.from(sensorSnapshot.value as Map);

        // Fetch status data
        final statusSnapshot = await statusRef.get();
        final statusData = statusSnapshot.value as Map<dynamic, dynamic>?;

        if (kDebugMode) {
          print('Sensor Data: $sensorData');
          print('Status Data: $statusData');
        }

        return SensorData(
          temperatureC: sensorData['temperatureC']?.toDouble() ?? 0.0,
          temperatureF: sensorData['temperatureF']?.toDouble() ?? 0.0,
          humidity: sensorData['humidity']?.toDouble() ?? 0.0,
          waterLevel: sensorData['waterLevel']?.toDouble() ?? 0.0,
          soilMoisture: sensorData['soilMoisture']?.toDouble() ?? 0.0,
          fanStatus: statusData?['fan'] ?? false,
          pumpStatus: statusData?['waterPump'] ?? false,
        );
      } else {
        if (kDebugMode) {
          print('Sensor snapshot does not exist or is null');
        }
        return null;
      }
    }).handleError((error) {
      if (kDebugMode) {
        print('Error fetching data: $error');
      }
      return null;
    });
  }
}