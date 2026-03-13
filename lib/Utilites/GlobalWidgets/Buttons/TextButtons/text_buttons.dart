import 'dart:ui';

import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextButtons {
  static Widget textButton({
    required String text,
    required VoidCallback onTap,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    TextStyle? textStyle
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onTap,
      child: Text(

        text,
        style: textStyle
      ),
    );
  }
}
