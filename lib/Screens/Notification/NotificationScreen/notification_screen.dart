import 'package:fin_wise/Bloc/AuthBloc/auth_event.dart';
import 'package:fin_wise/Bloc/NotificatioBloc/notification_bloc.dart';
import 'package:fin_wise/Screens/Notification/NotificationWidgets/notification_header_item.dart';
import 'package:fin_wise/Screens/Notification/NotificationWidgets/notification_item.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../NotificationWidgets/notification_list.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotificationBloc>().add(
      FetchNotificationsEvent(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
          title: TextsWidgets.notificationScreenTitle,
          backArrow: true,
          centerTitle: true
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {

          // if (state.notificationStatus == NotificationStatus.success) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text("Notification SuccessFully")),
          //   );
          // }
          // if (state.notificationStatus == NotificationStatus.error) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text("notification Failed")),
          //   );
          // }


          // if (notificationList.isEmpty) {
          //   return Center(child: Text("No Notifications"));
          // }


          return CommonAppUi(bottomWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

            child: ListView.builder(
              itemCount: state.notificationsList.length   ,
              itemBuilder: (context, index) {
                final data = state.notificationsList[index];

                return NotificationItem().notificationItem(title: data.title,body: data.body);
              }
            ),
          ), bottomSize: 76);
        },
      ),
    );
  }
}
