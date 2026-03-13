import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfullyPasswordScreen extends StatelessWidget {
  const SuccessfullyPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsWidgets.mainAppColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(ImagesWidget.progress,height: 142,)),
          SizedBox(height: 32,),
          Text(TextsWidgets.successfullyChangePassword,style: FontsWidgets.poppins(
            fontColor: ColorsWidgets.lightGreen,
            fontWeight: FontWeight.w600

          ),)
        ],
      ),
    );
  }
}
