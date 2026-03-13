import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../../Utilites/GlobalWidgets/MediaQuery/media_query.dart';

class CategoriesTransactionWidget {
  Widget transactionItemTile({
    required String icon,
    required String title,
    required String timeDate,
    required String amount,
    bool isExpense = false,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsWidgets.blue.withOpacity(0.15),
        ),
        child: Center(
          child: Image.asset(icon, height: 22, color: ColorsWidgets.blue),
        ),
      ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: FontsWidgets.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontColor: ColorsWidgets.darkGreen,
        ),
      ),
      subtitle: Text(
        timeDate,
        overflow: TextOverflow.ellipsis,
        style: FontsWidgets.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 10,
          fontColor: ColorsWidgets.blue,
        ),
      ),
      trailing: SizedBox(
        width: AppSize.widht(context) * 0.27,
        child: Text(
          amount,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: FontsWidgets.poppins(
            fontWeight: FontWeight.w500,
            fontColor: isExpense ? ColorsWidgets.blue : ColorsWidgets.darkGreen,
          ),
        ),
      ),
    );
  }
}