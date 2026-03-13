import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationHeaderItem {

  Widget headerItem(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: FontsWidgets.leagueSpartan(
          fontWeight: FontWeight.w400,
          fontColor: ColorsWidgets.darkGreen
        ),
      ),
    );
  }
}