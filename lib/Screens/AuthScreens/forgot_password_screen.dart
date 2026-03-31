import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../AppRoute/app_route.dart';
import '../../AppRoute/app_route_path.dart';
import '../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../Utilites/GlobalWidgets/Buttons/TextButtons/text_buttons.dart';
import '../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../Utilites/GlobalWidgets/CommonSocialSignup/common_social_signup.dart';
import '../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../Utilites/GlobalWidgets/TextFields/text_fields.dart';
import '../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonAppUi(
            topWidget: Text(  AppLocalizations.of(context)?.translate("forgotPass")??"forgotPass",

              style: FontsWidgets.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                fontColor: ColorsWidgets.darkGreen,
              ),
            ),
            bottomWidget: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 42),

                    Text(
                      AppLocalizations.of(
                            context,
                          )?.translate("resetPassword") ??
                          "resetPassword",
                      style: FontsWidgets.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        fontColor: ColorsWidgets.darkGreen,
                      ),
                    ),
                    SizedBox(height: 6),

                    Text(
                      AppLocalizations.of(context)?.translate("forgotDis") ??
                          "forgotDis",
                      style: FontsWidgets.leagueSpartan(
                        fontWeight: FontWeight.w400,
                        fontColor: ColorsWidgets.darkGreen,
                      ),
                    ),
                    SizedBox(height: 48),
                    TextFields.commonTextFormField(
                      keyboardType: TextInputType.emailAddress,

                      controller: emailController,
                      labelText:
                          AppLocalizations.of(
                            context,
                          )?.translate("forgotEmail") ??
                          "forgotEmail",

                      hintText:
                          AppLocalizations.of(
                            context,
                          )?.translate("forgotHintTextEmail") ??
                          "forgotHintTextEmail",

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                                context,
                              )?.translate("forgotValidationEmail") ??
                              "forgotValidationEmail";
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                      contentHorizontal: 20,
                      contentVertical: 10,
                      fillColor: ColorsWidgets.lightGreen,
                      hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                    ),
                    SizedBox(height: 49),
                    Center(
                      child: ButtonWidgets.appButton(
                        text: AppLocalizations.of(context)?.translate("forgotButtonNextStep")??"forgotButtonNextStep",

                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            // emailController.clear();
                            // passwordController.clear();
                            appRoute.push(AppRoutePath.newPasswordScreen.path);
                            print("forgot Success");
                          } else {
                            print("No Validation");
                          }
                        },
                        backgroundColor: ColorsWidgets.mainAppColor,
                        height: 40,
                        width: 207,
                        textColor: ColorsWidgets.darkGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 54),
                    Center(
                      child: ButtonWidgets.appButton(


                        text:  AppLocalizations.of(context)?.translate("signup")??"signup",
                        onTap: () {},
                        backgroundColor: ColorsWidgets.lightGreen,
                        height: 40,
                        width: 207,
                        textColor: ColorsWidgets.darkGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 24),

                    commonSocialSignup(
                      context,
                      onFacebookTap: () {},
                      onGoogleTap: () {},
                      onSignupTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            bottomSize: 6,
          ),
        ],
      ),
    );
  }
}
