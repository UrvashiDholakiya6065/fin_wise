import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ProfileWidgets/setting_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(

          title:           AppLocalizations.of(context)?.translate("settings")??"settings",

        centerTitle: true,
        backArrow: true,
      ),
      body: CommonAppUi(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 24),
          child: Column(
            children: [
              SettingItem(
                icon: Icons.notifications_none,



              title:              AppLocalizations.of(context)?.translate("notificationSetting")??"notificationSetting",

              onTap: (){
                  appRoute.push(AppRoutePath.notificationSettingScreen.path);
                },
              ),
              SizedBox(height: 12),
              GestureDetector(
                  onTap: (){
                    appRoute.push(AppRoutePath.passwordSettingScreen.path);
                  },
                  child: SettingItem(icon: Icons.key, title:                  AppLocalizations.of(context)?.translate("passwordSetting")??"passwordSetting",
                  )),
              SizedBox(height: 12),

              SettingItem(icon: Icons.person_outline, title:              AppLocalizations.of(context)?.translate("deleteAccount")??"deleteAccount",
              ),
            ],
          ),
        ),
        bottomSize: 24,
      ),
    );
  }
}
