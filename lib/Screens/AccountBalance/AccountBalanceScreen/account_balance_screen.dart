import 'package:fin_wise/Screens/AccountBalance/AccountBalanceWidgets/account_transaction_list.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AccountBalanceWidgets/account_balance_summery_widget.dart';
import '../AccountBalanceWidgets/account_transaction_item_widget.dart';

class AccountBalanceScreen extends StatelessWidget {
  const AccountBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        title: TextsWidgets.accountBalanceScreenTitle,
        centerTitle: true,
        backArrow: true,
      ),
      body: CommonAppUi(
        topWidget: AccountBalanceSummeryWidget().accountBalanceSummeryWidget(),
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
                      Text(TextsWidgets.accountBalanceScreenTransactions,style: FontsWidgets.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontColor: ColorsWidgets.darkGreen
                      ),),
                      Text(TextsWidgets.accountBalanceScreenSeeAll,style: FontsWidgets.leagueSpartan(
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
