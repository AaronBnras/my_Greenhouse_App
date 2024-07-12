import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_greenhouse/data/firebase_service.dart';
import 'dart:async';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Variables to track the last notification time and device states
  DateTime? _lastTemperatureNotification;
  DateTime? _lastHumidityNotification;
  DateTime? _lastSoilMoistureNotification;
  DateTime? _lastWaterLevelNotification;
  bool? _lastFanStatus;
  bool? _lastPumpStatus;

  // Constant for the cool-down period
  static const Duration notificationCooldown = Duration(minutes: 15);

  Future<void> init() async {
    await _fcm.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'channel_id',
              'channel_name',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });

    listenToSensorData();
  }

  void listenToSensorData() {
    FirebaseService().sensorDataStream.listen((sensorData) {
      if (sensorData != null) {
        if (kDebugMode) {
          print('Received sensor data: $sensorData');
        }

        _checkAndNotifyTemperature(sensorData.temperatureC);
        _checkAndNotifyHumidity(sensorData.humidity);
        _checkAndNotifySoilMoisture(sensorData.soilMoisture);
        _checkAndNotifyWaterLevel(sensorData.waterLevel);
        _checkAndNotifyFanStatus(sensorData.fanStatus);
        _checkAndNotifyPumpStatus(sensorData.pumpStatus);
      } else {
        if (kDebugMode) {
          print('Received null sensor data');
        }
      }
    });
  }

  void _checkAndNotifyTemperature(double temperature) {
    if (temperature > 32 && (_lastTemperatureNotification == null ||
        DateTime.now().difference(_lastTemperatureNotification!) > notificationCooldown)) {
      sendNotification('High Temperature', 'Temperature is above 32°C');
      _lastTemperatureNotification = DateTime.now();
      if (kDebugMode) {
        print('Temperature condition met, sending notification');
      }
    }
  }

  void _checkAndNotifyHumidity(double humidity) {
    if (humidity > 70 && (_lastHumidityNotification == null ||
        DateTime.now().difference(_lastHumidityNotification!) > notificationCooldown)) {
      sendNotification('High Humidity', 'Humidity is above 70%');
      _lastHumidityNotification = DateTime.now();
      if (kDebugMode) {
        print('Humidity condition met, sending notification');
      }
    }
  }

  void _checkAndNotifySoilMoisture(double soilMoisture) {
    if (soilMoisture < 30 && (_lastSoilMoistureNotification == null ||
        DateTime.now().difference(_lastSoilMoistureNotification!) > notificationCooldown)) {
      sendNotification('Low Soil Moisture', 'Soil moisture is below 30%');
      _lastSoilMoistureNotification = DateTime.now();
      if (kDebugMode) {
        print('Soil moisture condition met, sending notification');
      }
    }
  }

  void _checkAndNotifyWaterLevel(double waterLevel) {
    if (waterLevel < 30 && (_lastWaterLevelNotification == null ||
        DateTime.now().difference(_lastWaterLevelNotification!) > notificationCooldown)) {
      sendNotification('Low Water Level', 'Water level is below 30%');
      _lastWaterLevelNotification = DateTime.now();
      if (kDebugMode) {
        print('Water level condition met, sending notification');
      }
    }
  }

  void _checkAndNotifyFanStatus(bool fanStatus) {
    if (_lastFanStatus != fanStatus) {
      sendNotification('Fan Status', fanStatus ? 'Fan is turned on' : 'Fan is turned off');
      _lastFanStatus = fanStatus;
      if (kDebugMode) {
        print('Fan status changed, sending notification');
      }
    }
  }

  void _checkAndNotifyPumpStatus(bool pumpStatus) {
    if (_lastPumpStatus != pumpStatus) {
      sendNotification('Water Pump Status', pumpStatus ? 'Water pump is turned on' : 'Water pump is turned off');
      _lastPumpStatus = pumpStatus;
      if (kDebugMode) {
        print('Pump status changed, sending notification');
      }
    }
  }

  Future<void> sendNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'GreenHouse',
      'GreenHouse Farm',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}