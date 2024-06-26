// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCSMQYx3Wni4Vk13vzEMRkMEc57Vxx1IPo',
    appId: '1:420052989314:web:9a55d39fb61bd24e760b9b',
    messagingSenderId: '420052989314',
    projectId: 'greenhouse-farm',
    authDomain: 'greenhouse-farm.firebaseapp.com',
    databaseURL: 'https://greenhouse-farm-default-rtdb.firebaseio.com/',
    storageBucket: 'greenhouse-farm.appspot.com',
    measurementId: 'G-QMNZ7FWSVL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoUnwmATe_hHvO2zw9poCmLwtiI9c3D_8',
    appId: '1:420052989314:android:76df81c5f4120b36760b9b',
    messagingSenderId: '420052989314',
    projectId: 'greenhouse-farm',
    databaseURL: 'https://greenhouse-farm-default-rtdb.firebaseio.com/',
    storageBucket: 'greenhouse-farm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfzfR8qkjXr6-x83coLZyedM2kwT9tUhk',
    appId: '1:420052989314:ios:136b7f68682fd4fe760b9b',
    messagingSenderId: '420052989314',
    projectId: 'greenhouse-farm',
    databaseURL: 'https://greenhouse-farm-default-rtdb.firebaseio.com',
    storageBucket: 'greenhouse-farm.appspot.com',
    iosBundleId: 'com.example.myGreenhouse',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDfzfR8qkjXr6-x83coLZyedM2kwT9tUhk',
    appId: '1:420052989314:ios:1827b4d1be5067fb760b9b',
    messagingSenderId: '420052989314',
    projectId: 'greenhouse-farm',
    storageBucket: 'greenhouse-farm.appspot.com',
    iosBundleId: 'y',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCSMQYx3Wni4Vk13vzEMRkMEc57Vxx1IPo',
    appId: '1:420052989314:web:d0b5387b670f7845760b9b',
    messagingSenderId: '420052989314',
    projectId: 'greenhouse-farm',
    authDomain: 'greenhouse-farm.firebaseapp.com',
    databaseURL: 'https://greenhouse-farm-default-rtdb.firebaseio.com/',
    storageBucket: 'greenhouse-farm.appspot.com',
    measurementId: 'G-FP205V53DZ',
  );

}