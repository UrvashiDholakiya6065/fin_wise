import 'package:fin_wise/Screens/Notification/NotificationWidgets/notification_header_item.dart';
import 'package:fin_wise/Screens/Notification/NotificationWidgets/notification_item.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/material.dart';
import '../NotificationWidgets/notification_list.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        title: TextsWidgets.notificationScreenTitle,
        backArrow: true,
        centerTitle: true
      ),
      body: CommonAppUi( bottomWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 6),
        child: ListView.builder(
          itemCount: notificationList.length,
          itemBuilder: (context, index) {

            var item = notificationList[index];

            if (item["type"] == "header") {
              return NotificationHeaderItem().headerItem(item["title"]);
            } else {
              return NotificationItem().notificationItem(item);
            }

          },
        ),
      ), bottomSize: 76),
    );
  }
}
