import 'package:fin_wise/Screens/AccountBalance/AccountBalanceWidgets/account_transaction_list.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';
import '../AccountBalanceWidgets/account_balance_summery_widget.dart';
import '../AccountBalanceWidgets/account_transaction_item_widget.dart';

class AccountBalanceScreen extends StatelessWidget {
  const AccountBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactionsList = [
      {
        "icon": ImagesWidget.wallet,
        "title": "Salary",
        "timeDate": "18:27 - April 30",
        "category": "Monthly",
        "amount": formatAmount(4000,context),
        "isExpense": false
      },
      {
        "icon": ImagesWidget.groceriesIcon,
        "title": "Groceries",
        "timeDate": "17:00 - April 24",
        "category": "Pantry",
        "amount": formatAmount(-100,context),
        "isExpense": true
      },
      {
        "icon": ImagesWidget.rentIcon,
        "title": "Rent",
        "timeDate": "8:30 - April 15",
        "category": "Rent",
        "amount": formatAmount(-67440,context),
        "isExpense": true
      },
      {
        "icon": ImagesWidget.accountBalanceBusImg,
        "title": "Transport",
        "timeDate": "9:30 - April 08",
        "category": "Fuel",
        "amount": formatAmount(-413,context),
        "isExpense": true
      },
    ];
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(

        title:        AppLocalizations.of(context)?.translate("accountBalanceScreenTitle")??"accountBalanceScreenTitle",

        centerTitle: true,
        backArrow: true,
      ),
      body: CommonAppUi(
        topWidget: AccountBalanceSummeryWidget().accountBalanceSummeryWidget(context),
        bottomWidget:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 8),
          child: Column(
            children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(                      AppLocalizations.of(context)?.translate("accountBalanceScreenTransactions")??"accountBalanceScreenTransactions",
                        style: FontsWidgets.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontColor: ColorsWidgets.darkGreen
                      ),),


                      Text(                      AppLocalizations.of(context)?.translate("accountBalanceScreenSeeAll")??"accountBalanceScreenSeeAll",style: FontsWidgets.leagueSpartan(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontColor: ColorsWidgets.darkGreen
                      ),),

                    ],
                  ),
               ),

              SizedBox(height: 14,),
              ListView.builder(
                itemCount: transactionsList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {

                  final item = transactionsList[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AccountTransactionItemWidget().accountTransactionItemWidget(
                      icon: item["icon"],
                      title: item["title"],
                      timeDate: item["timeDate"],
                      category: item["category"],
                      amount: item["amount"],
                      isExpense: item["isExpense"], context: context,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomSize: 2,
      ),
    );
  }
}
