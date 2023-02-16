import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notfi/firebase_config.dart';
import 'package:notfi/home.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _firebaseMessagingOnBackground(RemoteMessage message) async {
  log('get background message');
  // ignore: avoid_print
  print('============================');
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  await notificationConfig();
  await firebaseInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingOnBackground);

  var status = await Permission.notification.isGranted;
  // ignore: avoid_print
  print(status);

  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // AndroidInitializationSettings androidInitializationSettings =
  //     const AndroidInitializationSettings('@mipmap/ic_launcher');
  // InitializationSettings initializationSettings = InitializationSettings(
  //   android: androidInitializationSettings,
  // );

  // flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onDidReceiveNotificationResponse: (details) {},
  // );

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
