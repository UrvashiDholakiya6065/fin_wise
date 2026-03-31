import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/TextFields/text_fields.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';

class NewPasswordScreen extends StatefulWidget {
   NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
   bool isPassword = true;
   bool isConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonAppUi(topWidget: Text(
            AppLocalizations.of(context)?.translate("newPassword")??"newPassword",
            style: FontsWidgets.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              fontColor: ColorsWidgets.darkGreen,
            ),
          ),bottomWidget:Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 42,),
                  TextFields.commonTextFormField(controller: passwordController,
                    keyboardType: TextInputType.emailAddress,

                    labelText: AppLocalizations.of(context)?.translate("newPassword")??"newPassword",

                    hintText: AppLocalizations.of(context)?.translate("hintTextPassword")??"hintTextPassword",

                    obscureText: isPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {

                        return  AppLocalizations.of(context)?.translate("newValidationPassword")??"newValidationPassword"
                      ;
                      }
                      if (value.length < 6) {
                        return "Password must be 6 characters";
                      }
                      return null;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPassword = !isPassword;
                        });

                        isConfirmPassword = true;


                      },
                      child: isPassword
                          ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          ImagesWidget.eyeOff,
                          height: 20,
                          width: 20,
              
                        ),
                      )
                          : Icon(Icons.visibility,color: ColorsWidgets.darkGreen,),
                    ), contentHorizontal: 20, contentVertical: 10, fillColor: ColorsWidgets.lightGreen, hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                  ),
                  SizedBox(height: 12,),
                  TextFields.commonTextFormField(controller: confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,

                    labelText: AppLocalizations.of(context)?.translate("confirmNewPassword")??"confirmNewPassword",

                    hintText: AppLocalizations.of(context)?.translate("hintTextPassword")??"hintTextPassword",

                    validator: (value) {
                      if (value == null || value.isEmpty) {

                      return AppLocalizations.of(context)?.translate("newValidationConfirmPassword")??"newValidationConfirmPassword";

                      }
                      if (value.length < 6) {
                        return "Password must be 6 characters";
                      } if (value != passwordController.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    obscureText: isConfirmPassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isConfirmPassword = !isConfirmPassword;
                        });
                      },
                      child: isConfirmPassword
                          ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          ImagesWidget.eyeOff,
                          height: 20,
                          width: 20,
                        ),
                      )
                          : Icon(Icons.visibility,color: ColorsWidgets.darkGreen,),
                    ), contentHorizontal: 20, contentVertical: 10, fillColor: ColorsWidgets.lightGreen, hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                  ),
                  SizedBox(height: 120,),
                  Center(
                    child: ButtonWidgets.appButton(

                      text:  AppLocalizations.of(context)?.translate("newChangePassword")??"newChangePassword",

                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          // fullNameController.clear();
                          // emailController.clear();
                          // mobileController.clear();
                          // dobController.clear();
                          // passwordController.clear();
                          // confirmPasswordController.clear();
                          // appRoute.push(AppRoutePath.otpScreen.path);
                          appRoute.push(AppRoutePath.successfullyPasswordScreen.path);
                          print("new password Success");
                        } else {
                          print("No Validation");
                        }
                      },
                      backgroundColor: ColorsWidgets.mainAppColor,
                      height: 40,
                      width: double.infinity,
                      textColor: ColorsWidgets.darkGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ), bottomSize: 6)
        ],
      ),
    );
  }
}
