import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationsStatusChanged>(_notificationChanged);

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

  void _handleRemoteMessage( RemoteMessage message ) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
  
    if (message.notification == null) return;

    print('Message also contained a notification: ${message.notification}');
  }

  void _onForegraoundMessage() {
    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
  }

  void _notificationChanged( NotificationsStatusChanged event, Emitter<NotificationsState> emit ) {
    emit(
      state.copyWih(
        status: event.status
      )
    );

    _getFCMT();
  }

  static Future<void> initFireabase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
