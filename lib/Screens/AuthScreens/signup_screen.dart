import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Model/user_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../AppRoute/app_route_path.dart';
import '../../Bloc/AuthBloc/auth_bloc.dart';
import '../../Bloc/AuthBloc/auth_event.dart';
import '../../SessionManage/shared_pref.dart';
import '../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../Utilites/GlobalWidgets/Buttons/TextButtons/text_buttons.dart';
import '../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../Utilites/GlobalWidgets/TextFields/text_fields.dart';
import '../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool isConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonAppUi(
            topWidget: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)?.translate("createAccount") ??
                        "createAccount",
                    style: FontsWidgets.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontColor: ColorsWidgets.darkGreen,
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Role",
                            style: FontsWidgets.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontColor: ColorsWidgets.darkGreen,
                            ),
                          ),
              
                          SizedBox(height: 12),
              
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
              
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                    SelectRoleEvent(role: "user"),
                                  );
                                },
                                child: Container(
                                  width: 100,
                                   height:54,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: state.selectedRole == "user"
                                        ? ColorsWidgets.white
                                        : ColorsWidgets.lightGreen,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: state.selectedRole == "user"
                                          ? ColorsWidgets.darkGreen
                                          : Colors.transparent,
              
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Users",
                                      style: FontsWidgets.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontColor: state.selectedRole == "user"
                                            ? Colors.black
                                            : ColorsWidgets.darkGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
              
                              SizedBox(width: 12),
              
                              GestureDetector(
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                    SelectRoleEvent(role: "admin"),
                                  );
                                },
                                child: Container(      width: 100,
                                  height:54,
              
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: state.selectedRole == "admin"
                                        ? ColorsWidgets.white
                                        : ColorsWidgets.lightGreen,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: state.selectedRole == "admin"
                                          ? ColorsWidgets.darkGreen
                                          : Colors.transparent,
                                                                 ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Admin",
                                      style: FontsWidgets.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontColor: state.selectedRole == "admin"
                                            ? Colors.black
                                            : ColorsWidgets.darkGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomWidget: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFields.commonTextFormField(
                        controller: fullNameController,

                        labelText:
                            AppLocalizations.of(
                              context,
                            )?.translate("labelFullName") ??
                            "labelFullName",

                        hintText:
                            AppLocalizations.of(
                              context,
                            )?.translate("hintTextFullName") ??
                            "hintTextFullName",

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                                  context,
                                )?.translate("signupValidationFullName") ??
                                "signupValidationFullName";
                          }
                          return null;
                        },
                        contentHorizontal: 20,
                        contentVertical: 10,
                        fillColor: ColorsWidgets.lightGreen,
                        hintFontColor: ColorsWidgets.darkGreen.withOpacity(
                          0.34,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFields.commonTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,

                        labelText:
                            AppLocalizations.of(
                              context,
                            )?.translate("lableEmail") ??
                            "lableEmail",
                        hintText:
                            AppLocalizations.of(
                              context,
                            )?.translate("hintTextEmail") ??
                            "hintTextEmail",

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                                  context,
                                )?.translate("signupValidationEmail") ??
                                "signupValidationEmail";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                        contentHorizontal: 20,
                        contentVertical: 10,
                        fillColor: ColorsWidgets.lightGreen,
                        hintFontColor: ColorsWidgets.darkGreen.withOpacity(
                          0.34,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFields.commonTextFormField(
                        keyboardType: TextInputType.number,
                        controller: mobileController,

                        labelText:
                            AppLocalizations.of(
                              context,
                            )?.translate("lableMobileNumber") ??
                            "lableMobileNumber",

                        hintText:
                            AppLocalizations.of(
                              context,
                            )?.translate("hintTextMobileNumber") ??
                            "hintTextMobileNumber",

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                                  context,
                                )?.translate("signupValidationMobileNumber") ??
                                "signupValidationMobileNumber";
                          }

                          return null;
                        },
                        contentHorizontal: 20,
                        contentVertical: 10,
                        fillColor: ColorsWidgets.lightGreen,
                        hintFontColor: ColorsWidgets.darkGreen.withOpacity(
                          0.34,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFields.commonTextFormField(
                        readOnly: true,
                        controller: dobController,

                        labelText:
                            AppLocalizations.of(
                              context,
                            )?.translate("lableDob") ??
                            "lableDob",

                        hintText:
                            AppLocalizations.of(
                              context,
                            )?.translate("hintTextDob") ??
                            "hintTextDob",

                        onTap: () async {
                          FocusScope.of(context).unfocus();

                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2026),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            dobController.text = DateFormat(
                              'dd/MM/yyyy',
                            ).format(pickedDate);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                                  context,
                                )?.translate("signupValidationDob") ??
                                "signupValidationDob";
                          }
                          return null;
                        },
                        contentHorizontal: 20,
                        contentVertical: 10,
                        fillColor: ColorsWidgets.lightGreen,
                        hintFontColor: ColorsWidgets.darkGreen.withOpacity(
                          0.34,
                        ),
                      ),
                      SizedBox(height: 12),

                      TextFields.commonTextFormField(
                        obscureText: isPassword,
                        controller: passwordController,

                        labelText:
                            AppLocalizations.of(
                              context,
                            )?.translate("password") ??
                            "password",

                        hintText:
                            AppLocalizations.of(
                              context,
                            )?.translate("hintTextPassword") ??
                            "hintTextPassword",

                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
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
                              : Icon(
                                  Icons.visibility,
                                  color: ColorsWidgets.darkGreen,
                                ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                                  context,
                                )?.translate("signupValidationPassword") ??
                                "signupValidationPassword";
                          }
                          if (value.length < 6) {
                            return "Password must be 6 characters";
                          }
                          return null;
                        },
                        contentHorizontal: 20,
                        contentVertical: 10,
                        fillColor: ColorsWidgets.lightGreen,
                        hintFontColor: ColorsWidgets.darkGreen.withOpacity(
                          0.34,
                        ),
                      ),
                      SizedBox(height: 12),

                      TextFields.commonTextFormField(
                        obscureText: isConfirmPassword,
                        controller: confirmPasswordController,

                        labelText:
                            AppLocalizations.of(
                              context,
                            )?.translate("lableConfirmPassword") ??
                            "lableConfirmPassword",

                        hintText:
                            AppLocalizations.of(
                              context,
                            )?.translate("hintTextConfirmPassword") ??
                            "hintTextConfirmPassword",

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
                              : Icon(
                                  Icons.visibility,
                                  color: ColorsWidgets.darkGreen,
                                ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)?.translate(
                                  "signupValidationConfirmPassword",
                                ) ??
                                "signupValidationConfirmPassword";
                          }
                          if (value != passwordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        contentHorizontal: 20,
                        contentVertical: 10,
                        fillColor: ColorsWidgets.lightGreen,
                        hintFontColor: ColorsWidgets.darkGreen.withOpacity(
                          0.34,
                        ),
                      ),
                      SizedBox(height: 54),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(
                                  context,
                                )?.translate("signupDis") ??
                                "signupDis",

                            style: FontsWidgets.leagueSpartan(
                              fontWeight: FontWeight.w400,
                              fontColor: ColorsWidgets.darkGrey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              TextButtons.textButton(
                                text:
                                    AppLocalizations.of(
                                      context,
                                    )?.translate("signupTerms") ??
                                    "signupTerms",

                                onTap: () {},
                                textStyle: FontsWidgets.leagueSpartan(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontColor: ColorsWidgets.darkGrey,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                AppLocalizations.of(
                                      context,
                                    )?.translate("signupAnd") ??
                                    "signupAnd",
                                style: FontsWidgets.leagueSpartan(
                                  fontWeight: FontWeight.w400,
                                  fontColor: ColorsWidgets.darkGrey,
                                ),
                              ),
                              SizedBox(width: 4),

                              TextButtons.textButton(
                                text:
                                    AppLocalizations.of(
                                      context,
                                    )?.translate("signupPrivacyPolicy") ??
                                    "signupPrivacyPolicy",

                                onTap: () {},
                                textStyle: FontsWidgets.leagueSpartan(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontColor: ColorsWidgets.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) async {
                          if (state.registrationStatus == AuthStatus.success) {
                            await SharedPref.setFromSplash(false);

                            appRoute.go(AppRoutePath.fingerprintScreen.path);
                          }

                          if (state.registrationStatus == AuthStatus.error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Signup Failed")),
                            );
                          }
                        },
                        builder: (context, state) {
                          final loading =
                              state.registrationStatus == AuthStatus.loading;

                          return Center(
                            child: ButtonWidgets.appButton(
                              isLoading: loading,

                              text:
                                  AppLocalizations.of(
                                    context,
                                  )?.translate("signup") ??
                                  "signup",

                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  // fullNameController.clear();
                                  // emailController.clear();
                                  // mobileController.clear();
                                  // dobController.clear();
                                  // passwordController.clear();
                                  // confirmPasswordController.clear();
                                  // appRoute.push(
                                  //   AppRoutePath.fingerprintScreen.path,
                                  // );

                                  context.read<AuthBloc>().add(
                                    SignupEvent(
                                      userModel: UserModel(
                                        fullName: fullNameController.text
                                            .trim(),
                                        email: emailController.text.trim(),
                                        mobileNumber: mobileController.text
                                            .trim(),
                                        dob: dobController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                        confirmPassword:
                                            confirmPasswordController.text
                                                .trim(),
                                        createdAt: DateTime.now().toString(),
                                        updatedAt: DateTime.now().toString(),
                                        role: state.selectedRole.toString(), uid: '',
                                      ),
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

                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(
                                  context,
                                )?.translate("alreadyHaveAnAccount") ??
                                "alreadyHaveAnAccount",

                            style: FontsWidgets.leagueSpartan(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(width: 4),
                          TextButtons.textButton(
                            text:
                                AppLocalizations.of(
                                  context,
                                )?.translate("login") ??
                                "login",

                            onTap: () {
                              appRoute.pop();
                            },
                            textStyle: FontsWidgets.leagueSpartan(
                              fontWeight: FontWeight.w300,
                              fontColor: ColorsWidgets.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
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
