import 'package:flutter/cupertino.dart';

import '../Colors/colors_widgets.dart';
import '../Fonts/fonts_widgets.dart';
import '../PngImages/images_widget.dart';
import '../Texts/language_controller.dart';

Widget commonSocialSignup(
    BuildContext context, {
      VoidCallback? onFacebookTap,
      VoidCallback? onGoogleTap,
      VoidCallback? onSignupTap,
    }) {
  return Column(
    children: [

      Text(
        AppLocalizations.of(context)?.translate("orSignUpWith") ?? "orSignUpWith",
        style: FontsWidgets.leagueSpartan(
          fontWeight: FontWeight.w300,
          fontColor: ColorsWidgets.darkGreen,
        ),
      ),

      const SizedBox(height: 18),

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
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onGoogleTap,
            child: Image.asset(
              ImagesWidget.google,
              height: 32,
            ),
          ),
        ],
      ),

      const SizedBox(height: 16),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)?.translate("dontHaveAccount") ?? "dontHaveAccount",
            style: FontsWidgets.leagueSpartan(
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onSignupTap,
            child: Text(
              AppLocalizations.of(context)?.translate("signup") ?? "signup",
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