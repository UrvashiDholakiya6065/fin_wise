import 'package:fin_wise/Bloc/ExpenseBloc/expense_bloc.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Categories/CategoriesWidgets/categories_list.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Categories/CategoriesWidgets/categories_transaction_list.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Categories/CategoriesWidgets/categories_transaction_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../AppRoute/app_route.dart';
import '../../../../AppRoute/app_route_path.dart';
import '../../../../Model/categorie_model.dart';
import '../../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../../Utilites/GlobalWidgets/MediaQuery/media_query.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import '../CategoriesWidgets/categories_widgets.dart';

class CategoriesDetailScreen extends StatefulWidget {
  final CategorieModel category;

  const CategoriesDetailScreen({super.key, required this.category});

  @override
  State<CategoriesDetailScreen> createState() => _CategoriesDetailScreenState();
}

class _CategoriesDetailScreenState extends State<CategoriesDetailScreen> {
  DateTime selectedMonth = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseBloc>().add(GetExpenseByCategoryEvent(cateId: widget.category.cateId));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
          backArrow: true,
          centerTitle: true,
          title: widget.category.categorieName
      ),
      body: CommonAppUi(
        topWidget: BalanceSummeryWidget().balanceSummaryWidget(),
        bottomWidget: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("April"),
                      GestureDetector(
                        onTap: () {
                          appRoute.push(AppRoutePath.calenderScreen.path);
                        },
                        child: Container(
                          height: 30,
                          width: 32,
                          decoration: BoxDecoration(
                            color: ColorsWidgets.mainAppColor,
                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              ImagesWidget.quicklyAnalysisCalenderImg,
                              height: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 24),
                BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    final expenses = state.expenseList ?? [];
                    // expenses.sort((a, b) {
                    //   DateTime dateA = DateFormat('MM/dd/yyyy').parse(a.date);
                    //   DateTime dateB = DateFormat('MM/dd/yyyy').parse(b.date);
                    //   return dateB.compareTo(dateA);
                    // });
                    //
                    // String lastMonth = "";
                    return ListView.builder(
                      itemCount: expenses.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = expenses[index];
                        // DateTime expenseDate =
                        // DateFormat('MM/dd/yyyy').parse(item.date);
                        //
                        // String currentMonth =
                        // DateFormat('MMMM yyyy').format(expenseDate);
                        //
                        // bool showHeader = currentMonth != lastMonth;
                        // lastMonth = currentMonth;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            // if (showHeader)
                            //   Padding(
                            //     padding:
                            //     const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            //     child: Text(
                            //       currentMonth,
                            //       style: const TextStyle(
                            //           fontSize: 18, fontWeight: FontWeight.bold),
                            //     ),
                            //   ),

                            Padding(

                              padding: const EdgeInsets.only(bottom: 8),
                              child: CategoriesTransactionWidget()
                                  .transactionItemTile(
                                icon: ImagesWidget.food,
                                title: item.expenseTitle,
                                timeDate: item.date,
                                amount: formatAmount(double.parse(item.amount)),
                                isExpense: true,
                                context: context,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: 24,),
                Center(
                  child: ButtonWidgets.appButton(
                    text: "Add Expense",
                    onTap: () async {
                      final result = await appRoute.push(
                        AppRoutePath.addExpenseScreen.path,
                        extra: widget.category.cateId,
                      );

                      if (result == true) {
                        context.read<ExpenseBloc>().add(
                          GetExpenseByCategoryEvent(cateId:  widget.category.cateId),
                        );
                      }
                    },
                    backgroundColor: ColorsWidgets.mainAppColor,
                    height: 45,
                    width: 207,
                    textColor: ColorsWidgets.darkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSize: 4,
      ),
    );
  }
}
