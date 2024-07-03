part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NotificationsStatusChanged extends NotificationsEvent {
  final AuthorizationStatus status;
  const NotificationsStatusChanged(this.status);
}

class NotificationsReceived extends NotificationsEvent {
  final PushMessage message;
  const NotificationsReceived(this.message);
}