import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:flutter/material.dart';

class ButtonWidgets {
  static Widget appButton({
    required String text,
    required VoidCallback onTap,
    double? height,
    double? width,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,bool isLoading=false
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ,
          borderRadius: BorderRadius.circular(30),
        ),
        child: isLoading?Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        ):Text(
          text,
          style: FontsWidgets.poppins(
            fontSize: fontSize,
              fontColor: textColor,
            fontWeight: fontWeight
          )
        )
      ),
    );
  }
}