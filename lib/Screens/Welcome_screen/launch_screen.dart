import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utilites/GlobalWidgets/Buttons/TextButtons/text_buttons.dart';
import '../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ImagesWidget.commonAppImage,
                color: ColorsWidgets.mainAppColor,
                width: 109,
                height: 114,
              ),
            ),
            SizedBox(height: 10),
            Text(
              TextsWidgets.fineWise,
              style: FontsWidgets.poppins(
                  fontColor: ColorsWidgets.mainAppColor,
                fontSize: 50,
                fontWeight: FontWeight.w600
        
              ),
            ),
            SizedBox(height: 3),
            Text(
              TextsWidgets.text,
              style: FontsWidgets.leagueSpartan(
                  fontColor: ColorsWidgets.darkGrey,
                fontSize: 14,
                fontWeight: FontWeight.w400
        
              ),
            ),
            SizedBox(height: 42,),
            ButtonWidgets.appButton(
              text: TextsWidgets.login,
              onTap: () {
                appRoute.go(AppRoutePath.loginScreen.path);
              },
              backgroundColor: ColorsWidgets.mainAppColor,
              height: 45,
              width: 207,
              textColor: ColorsWidgets.darkGreen,
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),
            SizedBox(height: 12,),
            ButtonWidgets.appButton(
              text:  TextsWidgets.signup,
              onTap: () {
                appRoute.push(AppRoutePath.signupScreen.path);

              },
              backgroundColor: ColorsWidgets.lightGreen,
              height: 45,
              width: 207,
              textColor: ColorsWidgets.darkGreen,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
            SizedBox(height: 12,),
            TextButtons.textButton(text: TextsWidgets.forgotPassword, onTap: (){
              appRoute.push(AppRoutePath.forgotPasswordScreen.path);
            },textStyle:  FontsWidgets.leagueSpartan(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontColor: ColorsWidgets.darkGreen,
            ),)
          ],
        ),
      ),
    );
  }
}
