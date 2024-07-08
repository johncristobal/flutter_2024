import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class LocalNotifications {
  static Future<void> requestPermissionsLocal() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> initLocalNotification() async {
    final plugin = FlutterLocalNotificationsPlugin();
    const settingsAndroid = AndroidInitializationSettings(
      "app_icon"
    );

    const initSettings = InitializationSettings(
      android: settingsAndroid
    );

    await plugin.initialize(
      initSettings
    );
  }

  static void showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  }) {
    const androidDetails = AndroidNotificationDetails(
      "channelId",
      "channelName",
      playSound: true,
      sound: RawResourceAndroidNotificationSound("notification"),
      importance: Importance.max,
      priority: Priority.max,
    );

    const details = NotificationDetails(
      android: androidDetails
    );
    
    final pluggin = FlutterLocalNotificationsPlugin();

    pluggin.show(id, title, body, details, payload: data);

  }
}