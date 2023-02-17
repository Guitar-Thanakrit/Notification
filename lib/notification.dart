import 'package:flutter_local_notifications/flutter_local_notifications.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', //id
  'high_importance_Notification', //name
  description: 'channel is used for impportant Notification',
  importance: Importance.max,
  showBadge: true,
  enableVibration: true,
  enableLights: true,
);
