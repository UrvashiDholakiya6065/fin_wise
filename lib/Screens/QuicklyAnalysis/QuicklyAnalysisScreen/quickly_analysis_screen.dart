import 'package:fin_wise/Screens/QuicklyAnalysis/QuicklyAnalysisWidgets/quickly_analysis_savings_goals_widget.dart';
import 'package:fin_wise/Screens/QuicklyAnalysis/QuicklyAnalysisWidgets/quickly_analysis_transaction_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../QuicklyAnalysisWidgets/bar_chart.dart';
import '../QuicklyAnalysisWidgets/quickly_analysis_transaction_list.dart';

class QuicklyAnalysisScreen extends StatelessWidget {
  const QuicklyAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        title: TextsWidgets.quicklyAnalysisScreenTitle,
        backArrow: true,
        centerTitle: true,
      ),
      body: CommonAppUi(
           topWidget: QuicklyAnalysisSavingsGoalsWidget().quicklyAnalysisSavingsGoalsWidget()
          ,bottomWidget: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 14),
              child: Column(
                children: [
                  BarChartSample2(),
                  SizedBox(height: 24,),
                  ListView.builder(
                    itemCount: transactions.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {

                      final item = transactions[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: QuicklyAnalysisTransactionWidget().quicklyAnalysisTransactionWidget(
                          icon: item["icon"],
                          title: item["title"],
                          timeDate: item["timeDate"],
                          category: item["category"],
                          amount: item["amount"],
                          isExpense: item["isExpense"],
                          context: context
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomSize: 6),
    );
  }
}
