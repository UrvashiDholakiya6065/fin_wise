import 'package:flutter/cupertino.dart';

import '../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import '../../../Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';

class ExpenseCardWidget {
  Widget expenseCardWidget(){
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
          color: ColorsWidgets.white,
          borderRadius: BorderRadius.circular(14),

      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagesWidget.expenseImg,height: 25,color: ColorsWidgets.blue,),
          SizedBox(height: 3,),
          Text(TextsWidgets.accountBalanceScreenExpense,style: FontsWidgets.poppins(
              fontWeight: FontWeight.w500,
              fontColor: ColorsWidgets.darkGreen
          ),),
          SizedBox(height: 3,),
          Text(formatAmount(1187.40),style: FontsWidgets.poppins(
              fontWeight: FontWeight.w600,
              fontColor: ColorsWidgets.blue,
              fontSize: 20
          ),),
        ],
      ),
    );
  }
}