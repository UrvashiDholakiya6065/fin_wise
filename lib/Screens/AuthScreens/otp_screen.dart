import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../Utilites/GlobalWidgets/CommonSocialSignup/common_social_signup.dart';
import '../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle:  TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorsWidgets.mainAppColor, width: 2),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          CommonAppUi(topWidget: Text(
            AppLocalizations.of(context)?.translate("securityPin")??"securityPin",

        style: FontsWidgets.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontColor: ColorsWidgets.darkGreen,
        ),
      ), bottomWidget: SingleChildScrollView(
        child: Column(
              children: [
                SizedBox(height: 42,),

                Text(                AppLocalizations.of(context)?.translate("enterSecurityPin")??"enterSecurityPin",
    style: FontsWidgets.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontColor: ColorsWidgets.darkGreen
                ),),
                SizedBox(height: 48,),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorsWidgets.mainAppColor, width: 3),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme,
                  separatorBuilder: (index) =>  SizedBox(width: 12),
                ),
                SizedBox(height: 88,),
                ButtonWidgets.appButton(

                  text: AppLocalizations.of(context)?.translate("otpAcceptButton")??"otpAcceptButton",

                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  backgroundColor: ColorsWidgets.mainAppColor,
                  height: 40,
                  width: 207,
                  textColor: ColorsWidgets.darkGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 18,),
                ButtonWidgets.appButton(

                  text:    AppLocalizations.of(context)?.translate("otpSendAgainButton")??"otpSendAgainButton",

                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  backgroundColor: ColorsWidgets.lightGreen,
                  height: 40,
                  width: 207,
                  textColor: ColorsWidgets.darkGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 60,),
                commonSocialSignup(
                  context,
                  onSignupTap: (){},
                  onFacebookTap: (){},
                  onGoogleTap: (){},
                )
              ],
            ),
      ), bottomSize: 6)
        ],
      ),
    );
  }
}
