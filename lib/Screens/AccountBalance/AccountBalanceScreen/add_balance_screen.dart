import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/Bloc/CategorieBloc/categorie_bloc.dart';
import 'package:fin_wise/Bloc/CategorieBloc/categorie_state.dart';
import 'package:fin_wise/Bloc/ExpenseBloc/expense_bloc.dart';
import 'package:fin_wise/Model/add_balance_model.dart';
import 'package:fin_wise/SessionManage/shared_pref.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/TextFields/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/NotificatioBloc/notification_bloc.dart';
import '../../../Model/notification_model.dart';
import '../../../Network/Services/notification_service.dart';
import '../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';

class AddBalanceScreen extends StatefulWidget {
  AddBalanceScreen({super.key});

  @override
  State<AddBalanceScreen> createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  TextEditingController addBalanceController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        backArrow: true,
        centerTitle: true,
        title: "Add Balance",
      ),
      body: CommonAppUi(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFields.commonTextFormField(
                keyboardType: TextInputType.number,
                labelText: "Add Balance",
                hintText: "₹ 20,000",

                controller: addBalanceController,
                contentHorizontal: 20,
                contentVertical: 10,
                fillColor: ColorsWidgets.lightGreen,
                hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
              ),
              SizedBox(height: 100),
              BlocConsumer<ExpenseBloc, ExpenseState>(
                listener: (context, state) {
                  if (state.addBalanceStatus == AddBalanceStatus.success) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text("")),
                    // );

                    final notification = NotificationModel(
                      title: "Balance",
                      body: "Balance added successfully ${state.addBalanceModel?.addBalance}",
                      timestamp: DateTime.now(),
                    );

                    NotificationService.showLocalNotificationFromData({
                      "title": notification.title,
                      "body": notification.body,
                    });

                    context.read<NotificationBloc>().add(
                      AddNotificationEvent(notificationModel: notification),
                    );
                    appRoute.pop();
                  }
                  if (state.addBalanceStatus == AddBalanceStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Balance error")),
                    );
                  }
                },
                builder: (context, state) {
                  final loading =
                      state.addBalanceStatus == AddBalanceStatus.loading;
                  return ButtonWidgets.appButton(
                    isLoading: loading,
                    text: "Add",
                    onTap: () async {
                      context.read<ExpenseBloc>().add(
                          AddBalanceEvent(addBalanceModel: AddBalanceModel(
                              addBalance: addBalanceController.text.trim(),
                              userId: await SharedPref.getUserUid()??"Unknown user" )));
                      // context.read<ExpenseBloc>().add(GetBalanceEvent());

                    },
                    backgroundColor: ColorsWidgets.mainAppColor,
                    height: 50,
                    width: 200,
                    textColor: ColorsWidgets.darkGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  );
                },
              ),
            ],
          ),
        ),
        bottomSize: 34,
      ),
    );
  }
}
