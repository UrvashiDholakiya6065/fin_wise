import 'package:flutter/cupertino.dart';

import '../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../Utilites/GlobalWidgets/MediaQuery/media_query.dart';

class AccountTransactionItemWidget {
  Widget accountTransactionItemWidget({   required String icon,
    required String title,
    required String timeDate,
    required String category,
    required String amount,
    required BuildContext context,
    bool isExpense = false,}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorsWidgets.blue.withOpacity(0.15),
          ),
          child: Center(
            child: Image.asset(icon, height: 26, color: ColorsWidgets.blue),
          ),
        ),

        SizedBox(width: 14),


        SizedBox(
          width: AppSize.widht(context) * 0.28,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,

                style: FontsWidgets.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontColor: ColorsWidgets.darkGreen,
                ),
              ),

              SizedBox(height: 4),

              Text(
                timeDate,
                overflow: TextOverflow.ellipsis,
                style: FontsWidgets.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  fontColor: ColorsWidgets.blue,
                ),
              ),
            ],
          ),
        ),


        Container(height: 28, width: 1, color: ColorsWidgets.mainAppColor),

        SizedBox(width: 10),

        SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: Text(
              category,
              overflow: TextOverflow.ellipsis,
              style: FontsWidgets.poppins(
                fontWeight: FontWeight.w300,
                fontColor: ColorsWidgets.darkGreen,
                fontSize: 12
              ),
            ),
          ),
        ),

        SizedBox(width: 10),

        Container(height: 28, width: 1, color: ColorsWidgets.mainAppColor),

        SizedBox(width: 10),

        Container(
          width: AppSize.widht(context)*0.27,
          child: Text(
            amount,
            overflow: TextOverflow.ellipsis,

            style: FontsWidgets.poppins(
              fontWeight: FontWeight.w500,
              fontColor: isExpense ? ColorsWidgets.blue : ColorsWidgets.darkGreen,
            ),
          ),
        ),
      ],
    );
  }
}
