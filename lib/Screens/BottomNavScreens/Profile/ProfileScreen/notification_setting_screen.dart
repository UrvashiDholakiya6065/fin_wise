import 'package:fin_wise/Screens/BottomNavScreens/Profile/ProfileWidgets/notification_list.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/ProfileSettingBloc/setting_bloc.dart';
import '../../../../Bloc/ProfileSettingBloc/setting_event.dart';
import '../../../../Bloc/ProfileSettingBloc/setting_state.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        backArrow: true,
        centerTitle: true,

          title:           AppLocalizations.of(context)?.translate("notificationSetting")??"notificationSetting",

      ),
      body: CommonAppUi(
        bottomWidget: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            // if (state.values.isEmpty) {
            // return Center(child: CircularProgressIndicator());
            //       }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 24),
              child: ListView.builder(
                itemCount: notificationItemList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(notificationItemList[index],style: FontsWidgets.poppins(
                          fontWeight: FontWeight.w500,
                          fontColor: ColorsWidgets.darkGreen
                        ),),
                        Switch(
                          value:
                               state.values[index],

                          onChanged: (val) {
                            print("Switch clicked: $val at index $index");

                            context.read<SettingBloc>().add(
                              ToggleSwitchEvent(index, val),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
        bottomSize: 24,
      ),
    );
  }
}
