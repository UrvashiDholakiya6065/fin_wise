import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';

class BalanceSummeryWidget {
  Widget balanceSummaryWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: (){
          print("Tap In Balance Summery");
          appRoute.push(AppRoutePath.accountBalanceScreen.path);
        },
        child: Container(
          height: 170,
          decoration: BoxDecoration(color: ColorsWidgets.mainAppColor),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(ImagesWidget.incomeImg, height: 12),
                            SizedBox(width: 4),
                            Text(
                              TextsWidgets.totalBalance,
                              style: FontsWidgets.poppins(
                                fontWeight: FontWeight.w400,
                                fontColor: ColorsWidgets.darkGreen,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          formatAmount(7783),
                          style: FontsWidgets.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            fontColor: ColorsWidgets.white,
                          ),
                        ),
                      ],
                    ),
            
                    Container(height: 40, width: 1, color: ColorsWidgets.white),
            
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Image.asset(ImagesWidget.expenseImg, height: 12),
                            SizedBox(width: 4),
                            Text(
                              TextsWidgets.totalExpense,
                              style: FontsWidgets.poppins(
                                fontWeight: FontWeight.w400,
                                fontColor: ColorsWidgets.darkGreen,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          formatAmount(-1187.40),
                          style: FontsWidgets.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            fontColor: ColorsWidgets.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            
                SizedBox(height: 15),
            
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorsWidgets.darkGreen,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorsWidgets.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
            
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "30%",
                            style: FontsWidgets.poppins(
                                fontWeight: FontWeight.w400,
                                fontColor: ColorsWidgets.white,
                                fontSize: 12
                            ),
                          ),
                        ),
                      ),
            
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            formatAmount(20000),
                            style: FontsWidgets.poppins(
                              fontWeight: FontWeight.w500,
                              fontColor: ColorsWidgets.darkGreen,   fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                SizedBox(height: 14),
            
                Row(
                  children: [
                    Icon(Icons.check_box_outlined,size: 16,),
                    SizedBox(width: 8),
                    Text(
                      TextsWidgets.expenseStatusMessage,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





