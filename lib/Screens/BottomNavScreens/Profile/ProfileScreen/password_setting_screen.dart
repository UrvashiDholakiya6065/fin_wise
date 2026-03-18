import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_bloc.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/AuthBloc/auth_event.dart';
import '../../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Enum/enum.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/TextFields/text_fields.dart';

class PasswordSettingScreen extends StatefulWidget {
  const PasswordSettingScreen({super.key});

  @override
  State<PasswordSettingScreen> createState() => _PasswordSettingScreenState();
}

class _PasswordSettingScreenState extends State<PasswordSettingScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isCurrentPassword = true;
  bool isNewPassword = true;
  bool isConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        title: TextsWidgets.passwordSetting,
        centerTitle: true,
        backArrow: true,
      ),
      body: CommonAppUi(
        bottomWidget: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 34),
            child: Column(
              children: [
                TextFields.commonTextFormField(
                  controller: currentPasswordController,
                  obscureText: isCurrentPassword,
                  labelText: "Current Password",
                  hintText: "Enter current password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isCurrentPassword = !isCurrentPassword;
                      });
                    },
                    child:  isCurrentPassword ?Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(ImagesWidget.eyeOff,   height: 20,
                        width: 20,),
                    ):Icon(
                     Icons.visibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter current password";
                    }
                    return null;
                  },
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                ),

                SizedBox(height: 16),

                TextFields.commonTextFormField(
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                  controller: newPasswordController,
                  obscureText: isNewPassword,
                  labelText: "New Password",
                  hintText: "Enter new password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isNewPassword = !isNewPassword;
                      });
                    },
                    child:isNewPassword?Padding(
                      padding: const EdgeInsets.all(12),
                      child:Image.asset(ImagesWidget.eyeOff,   height: 20,
                        width: 20,)):
                    Icon(
                       Icons.visibility,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter new password";
                    }
                    if (value.length < 6) {
                      return "Password must be 6 characters";
                    }

                    if (value == currentPasswordController.text) {
                      return "New password must be different";
                    }

                    return null;
                  },
                ),

                SizedBox(height: 16),

                TextFields.commonTextFormField(
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),

                  controller: confirmPasswordController,
                  obscureText: isConfirmPassword,
                  labelText: "Confirm Password",
                  hintText: "Re-enter new password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isConfirmPassword = !isConfirmPassword;
                      });
                    },
                    child: isConfirmPassword? Padding(
                        padding: const EdgeInsets.all(12),
                        child:Image.asset(ImagesWidget.eyeOff,   height: 20,
                          width: 20,)):Icon(
                   Icons.visibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm your password";
                    }

                    if (value != newPasswordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state.changePasswordStatus ==
                        ChangePasswordStatus.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password changed successfully"),
                        ),
                      );
                      appRoute.pop();
                    }
                    if (state.changePasswordStatus ==
                        ChangePasswordStatus.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.changePasswordError ??
                                "Error changing password",
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final loading=state.changePasswordStatus==ChangePasswordStatus.loading;
                    return Center(
                      child: ButtonWidgets.appButton(
                        isLoading: loading,
                        // isLoading: loading,
                        text: "Change Password",
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              ChangePasswordEvent(
                                currentPassword: currentPasswordController.text
                                    .trim(),
                                newPassword: newPasswordController.text.trim(),
                              ),
                            );
                          }
                        },

                        backgroundColor: ColorsWidgets.mainAppColor,
                        height: 45,
                        width: 207,
                        textColor: ColorsWidgets.darkGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomSize: 24,
      ),
    );
  }
}
