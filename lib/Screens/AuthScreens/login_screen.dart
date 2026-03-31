import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_bloc.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Model/login_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/TextFields/text_fields.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/AuthBloc/auth_event.dart';
import '../../SessionManage/shared_pref.dart';
import '../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../Utilites/GlobalWidgets/Buttons/TextButtons/text_buttons.dart';
import '../../Utilites/GlobalWidgets/CommonSocialSignup/common_social_signup.dart';
import '../../Utilites/GlobalWidgets/Enum/enum.dart';
import '../../Utilites/GlobalWidgets/FirebaseInstanceClass/firebase_instance_class.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonAppUi(
            topWidget: Text(


              AppLocalizations.of(context)?.translate("welcome")??"welcome",
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 42),
                      TextFields.commonTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        labelText:AppLocalizations.of(context)?.translate("userNameOrEmail")??"userNameOrEmail",

                        hintText: AppLocalizations.of(context)?.translate("hintTextEmail")??"hintTextEmail",

                        validator: (value) {
                          if (value == null || value.isEmpty) {

                          return   AppLocalizations.of(context)?.translate("loginValidationEmail")??"loginValidationEmail";
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
                        obscureText: isPassword,
                        controller: passwordController,

                        labelText: AppLocalizations.of(context)?.translate("password")??"password",
                        hintText: AppLocalizations.of(context)?.translate("hintTextPassword")??"hintTextPassword",


                        keyboardType: TextInputType.text,

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
                            return  AppLocalizations.of(context)?.translate("loginValidationPassword")??"loginValidationPassword";

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
                      SizedBox(height: 74),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) async {
                          if (state.registrationStatus == AuthStatus.success) {
                            // final idToken = await SharedPref.getUserIdAccessToken();
                              // print("Login Token: $idToken");
                              // await SharedPref.userIdAccessToken(idToken!);
                            // await SharedPref.setFromSplash(false);
                            //
                            // appRoute.go(AppRoutePath.fingerprintScreen.path);

                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final idToken = await user.getIdToken();
                              print("Login Token: $idToken");
                              await SharedPref.userIdAccessToken(idToken!);
                              await SharedPref.setFromSplash(false);

                              appRoute.go(AppRoutePath.fingerprintScreen.path);
                            }
                          }



                          if (state.registrationStatus == AuthStatus.error) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login faild")),
                            );
                          }
                        },
                        builder: (context, state) {
                          final loading =
                              state.registrationStatus == AuthStatus.loading;
                          return Center(
                            child: ButtonWidgets.appButton(
                              isLoading: loading,


                                text:   AppLocalizations.of(context)?.translate("login")??"login",
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState!.validate()) {
                                  // emailController.clear();
                                  // passwordController.clear();
                                  // appRoute.push(
                                  //   AppRoutePath.fingerprintScreen.path,
                                  // );
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      loginModel: LoginModel(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                      ),
                                    ),
                                  );   context.read<AuthBloc>().add(
                                    FetchUserEvent(),
                                  );


                                  print("Login Success");
                                } else {
                                  print("No Validation");
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
                      SizedBox(height: 18),
                      Center(
                        child: TextButtons.textButton(
                          text: AppLocalizations.of(context)?.translate("forgotPassword")??"forgotPassword",

                          onTap: () {
                            appRoute.push(
                              AppRoutePath.forgotPasswordScreen.path,
                            );
                          },
                          textStyle: FontsWidgets.leagueSpartan(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontColor: ColorsWidgets.darkGreen,
                          ),
                        ),
                      ),
                      SizedBox(height: 14),

                      Center(
                        child: ButtonWidgets.appButton(


                          text:    AppLocalizations.of(context)?.translate("signup")??"signup",

                          onTap: () {
                            appRoute.push(AppRoutePath.signupScreen.path);
                          },
                          backgroundColor: ColorsWidgets.lightGreen,
                          height: 45,
                          width: 207,
                          textColor: ColorsWidgets.darkGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.translate("use")??"use",

                            style: FontsWidgets.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontColor: ColorsWidgets.darkGreen,
                            ),
                          ),
                          SizedBox(width: 4),
                          TextButtons.textButton(

                            text: AppLocalizations.of(context)?.translate("fingerprint")??"fingerprint",

                            onTap: () {
                              appRoute.push(
                                AppRoutePath.fingerprintScreen.path,
                              );
                            },
                            textStyle: FontsWidgets.leagueSpartan(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontColor: ColorsWidgets.blue,
                            ),
                          ),
                          SizedBox(width: 4),

                          Text(
                            AppLocalizations.of(context)?.translate("toAccess")??"toAccess",
                            style: FontsWidgets.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontColor: ColorsWidgets.darkGreen,
                            ),
                          ),
                        ],
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
            ),
            bottomSize: 6,
          ),
        ],
      ),
    );
  }
}
