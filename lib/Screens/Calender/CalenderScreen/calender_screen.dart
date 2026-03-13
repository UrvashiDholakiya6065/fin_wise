import 'package:fin_wise/Screens/Calender/CalenderWidgets/calender_transaction_list.dart';
import 'package:fin_wise/Screens/Calender/CalenderWidgets/expense_chart.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../CalenderWidgets/calender_transaction_item.dart';
import '../CalenderWidgets/calender_widget.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        title: TextsWidgets.calenderScreenTitle,
        backArrow: true,
        centerTitle: true,
      ),
      body: CommonAppUi(
        bottomWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CalenderWidget(),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidgets.appButton(
                      backgroundColor: selectedIndex == 0
                          ? ColorsWidgets.mainAppColor
                          : ColorsWidgets.lightGreen,
                      text: TextsWidgets.calenderScreenSpends,
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      textColor: ColorsWidgets.darkGreen,
                      height: 45,
                      width: 154,
                    ),
                    ButtonWidgets.appButton(
                      backgroundColor: selectedIndex == 1
                          ? ColorsWidgets.mainAppColor
                          : ColorsWidgets.lightGreen,
                      text: TextsWidgets.calenderScreenCategories,
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      textColor: ColorsWidgets.darkGreen,
                      height: 45,
                      width: 154,
                    ),
                  ],
                ),
                SizedBox(height: 24,),
                selectedIndex == 0?ListView.builder(
                  itemCount: transactionsLists.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
            
                    final item = transactionsLists[index];
            
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: CalenderTransactionItemWidget().calenderTransactionItemWidget(
                        icon: item["icon"],
                        title: item["title"],
                        timeDate: item["timeDate"],
                        category: item["category"],
                        amount: item["amount"],
                        isExpense: item["isExpense"], context: context,
                      ),
                    );
                  },
                ):CalendarPieChart()
              ],
            ),
          ),
        ),
        bottomSize: 24,
      ),
    );
  }
}
