import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_greenhouse/data/firebase_service.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
        if (sensorData.temperatureC > 32) {
          sendNotification('High Temperature', 'Temperature is above 32°C');
        }
        if (sensorData.humidity > 70) {
          sendNotification('High Humidity', 'Humidity is above 70%');
        }
        if (sensorData.soilMoisture < 30) {
          sendNotification('Low Soil Moisture', 'Soil moisture is below 30%');
        }
        if (sensorData.waterLevel < 30) {
          sendNotification('Low Water Level', 'Water level is below 30%');
        }
        if (sensorData.fanStatus) {
          sendNotification('Fan Status', 'Fan is turned on');
        } else {
          sendNotification('Fan Status', 'Fan is turned off');
        }
        if (sensorData.pumpStatus) {
          sendNotification('Water Pump Status', 'Water pump is turned on');
        } else {
          sendNotification('Water Pump Status', 'Water pump is turned off');
        }
      }
    });
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