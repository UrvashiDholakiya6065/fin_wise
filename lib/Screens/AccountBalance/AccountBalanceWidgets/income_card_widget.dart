import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';

import '../../../Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';

class IncomeCardWidget {
  Widget incomeCardWidget(){
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        color: ColorsWidgets.white,
        borderRadius: BorderRadius.circular(14)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagesWidget.incomeImg,height: 25,color: ColorsWidgets.mainAppColor,),
          SizedBox(height: 3,),
          Text(TextsWidgets.accountBalanceScreenIncome,style: FontsWidgets.poppins(
            fontWeight: FontWeight.w500,
            fontColor: ColorsWidgets.darkGreen
          ),),
          SizedBox(height: 3,),
          Text(                        formatAmount(4000),
              style: FontsWidgets.poppins(
              fontWeight: FontWeight.w600,
              fontColor: ColorsWidgets.darkGreen,
            fontSize: 20
          ),),
        ],
      ),
    );
  }
}