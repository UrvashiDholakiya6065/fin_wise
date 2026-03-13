import 'package:flutter/cupertino.dart';

import '../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';

class SearchTransactionItem {
  Widget searchTransactionItem({
    required String icon,
    required String title,
    required String timeDate,
    required String amount,
    bool isExpense = false,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ColorsWidgets.lightGreen.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsWidgets.blue.withOpacity(0.15),
            ),
            child: Center(
              child: Image.asset(
                icon,
                height: 22,
                color: ColorsWidgets.blue,
              ),
            ),
          ),

           SizedBox(width: 14),

          Expanded(
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
                  style: FontsWidgets.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    fontColor: ColorsWidgets.blue,
                  ),
                ),
              ],
            ),
          ),

          Text(
            amount,
            style: FontsWidgets.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontColor:
              isExpense ? ColorsWidgets.blue : ColorsWidgets.darkGreen,
            ),
          ),
        ],
      ),
    );
  }
}