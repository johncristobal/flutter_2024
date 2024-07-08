import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s21_push/config/local/local_push.dart';
import 'package:s21_push/domain/entities/push_message.dart';
import 'package:s21_push/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int pushNumberId = 0;

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationsStatusChanged>(_notificationChanged);
    on<NotificationsReceived>(_notificationReceived);

    // verify status
    _initialCheck();

    // listener push foreground
    _onForegraoundMessage();
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // solicitar permiso a local push
    await LocalNotifications.requestPermissionsLocal();
    add(NotificationsStatusChanged(settings.authorizationStatus));
  }

  void _initialCheck() async {
    final settings = await messaging.getNotificationSettings();
     add(NotificationsStatusChanged(settings.authorizationStatus));
  }

  void _getFCMT() async {
    if(state.status != AuthorizationStatus.authorized) return;
    final token = await messaging.getToken();
    print(token);
  }

  void handleRemoteMessage( RemoteMessage message ) {
    if (message.notification == null) return;
    print('Message also contained a notification: ${message.notification}');

    final noti = PushMessage(
      messageId: message.messageId
      ?.replaceAll(":", "").replaceAll("%", "")
      ?? "",
      title: message.notification!.title ?? "",
      body: message.notification!.body ?? "",
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
      ? message.notification!.android?.imageUrl
      : message.notification!.apple?.imageUrl
    );

    LocalNotifications.showLocalNotification(
      id: ++pushNumberId,
      body: noti.body,
      title: noti.title,
      data: noti.data.toString()
    );
    add(NotificationsReceived(noti));
  }

  void _onForegraoundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void _notificationChanged( NotificationsStatusChanged event, Emitter<NotificationsState> emit ) {
    emit(
      state.copyWih(
        status: event.status
      )
    );

    _getFCMT();
  }

  void _notificationReceived( NotificationsReceived event, Emitter<NotificationsState> emit ) {
    emit(
      state.copyWih(
        notifications: [ event.message, ... state.notifications] //list
      )
    );
  }

  static Future<void> initFireabase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  PushMessage? getMessageById(String id) {
    final exists = state.notifications.any((element) => element.messageId == id);
    if(!exists) return null;

    return state.notifications.firstWhere((element) => element.messageId == id);
  }

}
