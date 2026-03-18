part of 'notification_bloc.dart';

 class NotificationState {
   final NotificationStatus? notificationStatus;
   final List<NotificationModel> notificationsList;


   const NotificationState({this.notificationStatus,this.notificationsList=const []});


   NotificationState copyWith({
     NotificationStatus? notificationStatus,
     List<NotificationModel>? notificationsList
 }){
     return NotificationState(
       notificationStatus: notificationStatus??this.notificationStatus,
       notificationsList: notificationsList??this.notificationsList
     );
   }
   List<Object?> get props => [notificationStatus,notificationsList];
 }


