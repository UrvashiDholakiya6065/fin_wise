import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationItem {
  Widget notificationItem(Map data) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorsWidgets.mainAppColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(data["imageIcon"],height: 28,color: ColorsWidgets.darkGreen,),
            ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["title"],
                    style: FontsWidgets.poppins(
                      fontWeight: FontWeight.w500,
                      fontColor: ColorsWidgets.darkGreen
                    )
                  ),

                  SizedBox(height: 4),

                  Text(
                    data["subtitle"],
                    style: FontsWidgets.leagueSpartan(
                        fontWeight: FontWeight.w400,
                        fontColor: ColorsWidgets.darkGreen
                    )
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      data["time"],
                      style:  FontsWidgets.poppins(
                          fontWeight: FontWeight.w300,
                          fontColor: ColorsWidgets.blue,
                        fontSize: 12
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Divider(
          color: ColorsWidgets.mainAppColor,
        )
      ],
    );
  }
}