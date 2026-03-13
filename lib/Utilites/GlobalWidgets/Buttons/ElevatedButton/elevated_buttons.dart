import 'dart:ui';

import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ElevatedButtons {
  static Widget elevatedButton({
    required String text,
    required VoidCallback onTap,
    Color? textColor,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight
  }){
    return ElevatedButton(
      onPressed: onTap,
        style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
    ),


    ), child:   Text(
    text,style: FontsWidgets.leagueSpartan(
    fontWeight:fontWeight,
    fontSize: fontSize,
      fontColor: textColor,

    ),
    ));
  }
}