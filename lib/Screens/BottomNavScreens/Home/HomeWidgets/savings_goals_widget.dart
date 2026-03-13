import 'package:flutter/cupertino.dart';

import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import '../../../../Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';

class SavingsGoalsWidget {
  Widget savingsGoalsWidget() {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: ColorsWidgets.mainAppColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsWidgets.blue, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(ImagesWidget.carImg),
                ),
              ),
              SizedBox(height: 6),
              Text(
                TextsWidgets.savingsOnGoals,
                textAlign: TextAlign.center,
                style: FontsWidgets.poppins(
                  fontWeight: FontWeight.w500,
                  fontColor: ColorsWidgets.darkGreen,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Container(height: 100, width: 1, color: ColorsWidgets.white),

          SizedBox(width: 16),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(ImagesWidget.wallet, height: 24),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextsWidgets.revenueLastWeek,
                          style: FontsWidgets.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontColor: ColorsWidgets.darkGreen,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          formatAmount(4000),
                          style: FontsWidgets.inter(
                            fontWeight: FontWeight.w600,
                            fontColor: ColorsWidgets.darkGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 8),

                Container(height: 1, color: ColorsWidgets.white),

                SizedBox(height: 8),

                Row(
                  children: [
                    Image.asset(ImagesWidget.food, height: 24),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextsWidgets.foodLastWeek,
                          style: FontsWidgets.poppins(
                            fontWeight: FontWeight.w400,
                            fontColor: ColorsWidgets.darkGreen,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          formatAmount(-100),
                          style: FontsWidgets.inter(
                            fontWeight: FontWeight.w700,
                            fontColor: ColorsWidgets.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
