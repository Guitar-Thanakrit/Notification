// ignore_for_file: avoid_print

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notfi/notification.dart';
import 'dart:io';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('$token');
    setState(() {
      _token = token;
    });
  }

  String osVersion = Platform.operatingSystemVersion;
  String? androidVersion;
  int? sdkVersion;

  foregroundMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      print(' get foreground Message');
      print('send ${message.data}');

      RemoteNotification? notification = message.notification;
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.max,
            ),
          ),
        );
      }
    });
  }

  versionCheck() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;

    print('$sdkVersion -- $androidVersion');

    setState(() {
      androidVersion = androidInfo.version.release;
      sdkVersion = androidInfo.version.sdkInt;
    });
  }

  // var release = and

  String? _token;

  @override
  void initState() {
    super.initState();
    foregroundMessage();
    versionCheck();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text(_token ?? 'WTF'),
            ),
            TextButton(
              onPressed: (() async {
                await Clipboard.setData(ClipboardData(text: _token));
              }),
              child: const Text('Copy'),
            ),
            Text('OS VERSION :  $osVersion'),
            Text('Android Version  : $androidVersion  '),
            Text('SDK Version  : $sdkVersion  '),
          ],
        ),
      ),
    );
  }
}
