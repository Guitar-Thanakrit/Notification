import 'dart:developer';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notfi/firebase_config.dart';
import 'package:notfi/home.dart';
import 'package:notfi/notification.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _firebaseMessagingOnBackground(RemoteMessage message) async {
  log('get background message');
  // ignore: avoid_print
  print('============================');
}

Future<void> main() async {
  //firebase setup
  await firebaseInitialized();
  var status = await Permission.notification.isGranted;
  // ignore: avoid_print
  print(status);

  //BackgroundMessage
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingOnBackground);

  //initailse plugin.

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  InitializationSettings initializationSettings = const InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:
          ((NotificationResponse notificationResponse) async {
    log("---------------------------------------------");
    // notificationResponse
  }));

  var androidInfo = await DeviceInfoPlugin().androidInfo;
  var release = androidInfo.version.release;
  var sdkInt = androidInfo.version.sdkInt;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
