import 'package:fin_wise/Bloc/ProfileSettingBloc/setting_event.dart';
import 'package:fin_wise/Bloc/ProfileSettingBloc/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Screens/BottomNavScreens/Profile/ProfileWidgets/notification_list.dart';

class SettingBloc extends Bloc<SettingsEvent, SettingState> {
  SettingBloc()
      : super(SettingState(values:List.generate(notificationItemList.length, (_) => false),),) {

    on<ToggleSwitchEvent>(toggleSwitch);
  }

  void toggleSwitch(
      ToggleSwitchEvent event,
      Emitter<SettingState> emit,
      ) {
    print("Before: ${state.values}");

    final updatedList = List<bool>.from(state.values);
    updatedList[event.index] = event.value;

    print("After: $updatedList");

    emit(state.copyWith(values: updatedList));
  }
}