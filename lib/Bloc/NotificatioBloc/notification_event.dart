part of 'notification_bloc.dart';

 class NotificationEvent {}

class AddNotificationEvent extends NotificationEvent{
  final NotificationModel notificationModel;

  AddNotificationEvent({required this.notificationModel});
}

class FetchNotificationsEvent extends NotificationEvent {}