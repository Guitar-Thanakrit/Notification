// ignore_for_file: avoid_print

import 'package:flutter/services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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

  foregroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(' get foreground Message');
      print('send ${message.data}');
      if (message.notification != null) {}
    });
  }

  String? _token;

  @override
  void initState() {
    super.initState();
    foregroundMessage();
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
              child: Text(_token ?? ''),
            ),
            TextButton(
              onPressed: (() async {
                await Clipboard.setData(ClipboardData(text: _token));
              }),
              child: const Text('Copy'),
            ),
          ],
        ),
      ),
    );
  }
}
