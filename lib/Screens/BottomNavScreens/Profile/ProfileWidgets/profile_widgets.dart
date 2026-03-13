import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidgets {

  Widget profileTile(String iconImage, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: ColorsWidgets.blue.withOpacity(0.24),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(iconImage,color: ColorsWidgets.white,),
            )
          ),
           SizedBox(width: 16),
          Text(
            title,
            style: FontsWidgets.poppins(
              fontWeight: FontWeight.w500,
              fontColor: ColorsWidgets.darkGreen
            )
          )
        ],
      ),
    );
  }

}