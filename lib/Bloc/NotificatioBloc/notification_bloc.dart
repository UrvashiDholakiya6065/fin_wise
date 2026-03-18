import 'package:bloc/bloc.dart';
import 'package:fin_wise/Network/Repository/repository.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';

import '../../Model/notification_model.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
Repository repository;
  NotificationBloc(this.repository) : super(NotificationState()) {
    on<AddNotificationEvent>(notificationBloc);
    on<FetchNotificationsEvent>(fetchNotifications);
  }


  void notificationBloc(AddNotificationEvent event, emit) async {
    emit(state.copyWith(notificationStatus: NotificationStatus.loading));

    try{
      await repository.addNotification(notificationModel: event.notificationModel);

      emit(state.copyWith(notificationStatus: NotificationStatus.success));
    } catch (e) {
      emit(state.copyWith(notificationStatus: NotificationStatus.error));
    }

  }
Future<void> fetchNotifications(
    FetchNotificationsEvent event,
    Emitter<NotificationState> emit) async {
  try {
    emit(state.copyWith(notificationStatus: NotificationStatus.loading));

    final data = await repository.getNotifications();
    print("Fetched notifications: $data");

    emit(state.copyWith(
      notificationStatus: NotificationStatus.success,
      notificationsList: data,
    ));
    emit(state.copyWith(notificationStatus: NotificationStatus.success));
  } catch (e) {
    emit(state.copyWith(notificationStatus: NotificationStatus.error));
  }
}
}

