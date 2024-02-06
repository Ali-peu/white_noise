import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() async {
    // Initialization  setting for android

    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
            android: AndroidInitializationSettings("@drawable/ic_launcher"));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );

    var androidPlatformChannelSpecifics = const AndroidNotificationChannel(
      'my_unique_channel_id', // уникальный идентификатор канала
      'My Notification Channel', // имя канала

      importance: Importance.high,
      // priority: Priority.high, // Уберите эту строку, если она вызывает ошибку
    );

    if (Platform.isAndroid) {
      // TODO IOS
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidPlatformChannelSpecifics);
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  void showNotificationOnLimits(String tittle, String body) async {
    await _notificationsPlugin.show(
        0,
        tittle,
        body,
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'my_unique_channel_id',
          'My Notification Channel',
        )));
  }
}
