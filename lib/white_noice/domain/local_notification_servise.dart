import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServise {
  static final LocalNotificationServise _localNotificationServise =
      LocalNotificationServise._internal();

  factory LocalNotificationServise() {
    return _localNotificationServise;
  }

  LocalNotificationServise._internal();

  void askRequest() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void init() async{
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon'); // TODO

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    //  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        // onSelectNotification: selectNotification);
  }
}
