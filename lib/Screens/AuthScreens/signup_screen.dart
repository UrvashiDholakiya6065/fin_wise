import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Model/user_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
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
            topWidget: Text(
              TextsWidgets.createAccount,
              style: FontsWidgets.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                fontColor: ColorsWidgets.darkGreen,
              ),
            ),
            bottomWidget: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFields.commonTextFormField(
                        controller: fullNameController,
                        labelText: TextsWidgets.lableFullName,
                        hintText: TextsWidgets.hintTextFullName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return TextsWidgets.signupValidationFullName;
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
                        labelText: TextsWidgets.lableEmail,
                        hintText: TextsWidgets.hintTextEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return TextsWidgets.signupValidationEmail;
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
                        labelText: TextsWidgets.lableMobileNumber,
                        hintText: TextsWidgets.hintTextMobileNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return TextsWidgets.signupValidationMobileNumber;
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
                        labelText: TextsWidgets.lableDob,
                        hintText: TextsWidgets.hintTextDob,
                        onTap: () async {
                          FocusScope.of(context).unfocus();

                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
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
                            return TextsWidgets.signupValidationDob;
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
                        labelText: TextsWidgets.password,
                        hintText: TextsWidgets.hintTextPassword,
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
                            return TextsWidgets.signupValidationPassword;
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
                        labelText: TextsWidgets.lableConfirmPassword,
                        hintText: TextsWidgets.hintTextConfirmPassword,

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
                            return TextsWidgets.signupValidationConfirmPassword;
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
                            TextsWidgets.signupDis,
                            style: FontsWidgets.leagueSpartan(
                              fontWeight: FontWeight.w400,
                              fontColor: ColorsWidgets.darkGrey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              TextButtons.textButton(
                                text: TextsWidgets.signupTerms,
                                onTap: () {},
                                textStyle: FontsWidgets.leagueSpartan(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontColor: ColorsWidgets.darkGrey,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                TextsWidgets.signupAnd,
                                style: FontsWidgets.leagueSpartan(
                                  fontWeight: FontWeight.w400,
                                  fontColor: ColorsWidgets.darkGrey,
                                ),
                              ),
                              SizedBox(width: 4),

                              TextButtons.textButton(
                                text: TextsWidgets.signupPrivacyPolicy,
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
                          final loading = state.registrationStatus == AuthStatus.loading;


                          return Center(
                            child: ButtonWidgets.appButton(
                              isLoading: loading,
                              text: TextsWidgets.signup,
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
                            TextsWidgets.alreadyHaveAnAccount,
                            style: FontsWidgets.leagueSpartan(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(width: 4),
                          TextButtons.textButton(
                            text: TextsWidgets.login,
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
