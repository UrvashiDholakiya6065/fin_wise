import 'package:flutter/material.dart';
import '../Colors/colors_widgets.dart';
import '../Fonts/fonts_widgets.dart';
import '../PngImages/images_widget.dart';
import '../Texts/texts_widgets.dart';

Widget commonSocialSignup({
  VoidCallback? onFacebookTap,
  VoidCallback? onGoogleTap,
  VoidCallback? onSignupTap,
}) {
  return Column(
    children: [

      Text(
        TextsWidgets.orSignUpWith,
        style: FontsWidgets.leagueSpartan(
          fontWeight: FontWeight.w300,
          fontColor: ColorsWidgets.darkGreen,
        ),
      ),

       SizedBox(height: 18),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onFacebookTap,
            child: Image.asset(
              ImagesWidget.faceBook,
              height: 32,
            ),
          ),
           SizedBox(width: 12),
          GestureDetector(
            onTap: onGoogleTap,
            child: Image.asset(
              ImagesWidget.google,
              height: 32,
            ),
          ),
        ],
      ),

       SizedBox(height: 16),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TextsWidgets.dontHaveAccount,
            style: FontsWidgets.leagueSpartan(
              fontWeight: FontWeight.w300,
            ),
          ),
           SizedBox(width: 4),
          GestureDetector(
            onTap: onSignupTap,
            child: Text(
              TextsWidgets.signup,
              style: FontsWidgets.leagueSpartan(
                fontWeight: FontWeight.w300,
                fontColor: ColorsWidgets.blue,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}