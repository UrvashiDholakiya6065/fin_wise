import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../Bloc/AuthBloc/auth_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_event.dart';
import '../../../../Bloc/AuthBloc/auth_state.dart';
import '../../../../Model/user_model.dart';
import '../../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../../../Utilites/GlobalWidgets/Enum/enum.dart';
import '../../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../../Utilites/GlobalWidgets/TextFields/text_fields.dart';
import '../../../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';

class EditProfile extends StatefulWidget {
 const  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController dobController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    final state = context.read<AuthBloc>().state;
    final user = state.userModel;

    if (user != null) {
      fullNameController.text = user.fullName;
      emailController.text = user.email;
      mobileController.text = user.mobileNumber;
      dobController.text = user.dob;
      passwordController.text=user.password;
      confirmPasswordController.text=user.confirmPassword;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonAppUi(
        bottomWidget: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -45,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(ImagesWidget.profileScreenImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final user=state.userModel;
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            user?.fullName??"User",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                      
                          Text(
                            user?.email??"User@gmail.com",
                            style: TextStyle(color: Colors.grey),
                          ),
                      
                          SizedBox(height: 35),
                      
                              TextFields.commonTextFormField(
                                controller: fullNameController,


                                labelText:   AppLocalizations.of(context)?.translate("lableFullName")??"lableFullName",
                                hintText: AppLocalizations.of(context)?.translate("hintTextFullName")??"hintTextFullName",

                                validator: (value) {
                                  if (value == null || value.isEmpty) {

                                  return AppLocalizations.of(context)?.translate("signupValidationFullName")??"signupValidationFullName";

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

                                labelText:                                 AppLocalizations.of(context)?.translate("lableEmail")??"lableEmail",

                                hintText:                                 AppLocalizations.of(context)?.translate("hintTextEmail")??"hintTextEmail",

                                validator: (value) {
                                  if (value == null || value.isEmpty) {

                                  return AppLocalizations.of(context)?.translate("signupValidationEmail")??"signupValidationEmail";

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

                                labelText:  AppLocalizations.of(context)?.translate("lableMobileNumber")??"lableMobileNumber",

                                hintText:                                 AppLocalizations.of(context)?.translate("hintTextMobileNumber")??"hintTextMobileNumber",

                                validator: (value) {
                                  if (value == null || value.isEmpty) {

                                  return  AppLocalizations.of(context)?.translate("signupValidationMobileNumber")??"signupValidationMobileNumber";

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

                                labelText:   AppLocalizations.of(context)?.translate("lableDob")??"lableDob",

                                hintText: AppLocalizations.of(context)?.translate("hintTextDob")??"hintTextDob",

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


                                  return                                     AppLocalizations.of(context)?.translate("signupValidationDob")??"signupValidationDob";

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
                      
                              BlocConsumer<AuthBloc, AuthState>(
                                listener: (context, state) async {
                                  if (state.editProfileStatus == EditProfileStatus.success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("edit profile succes")),
                                    );
                                    appRoute.pop();

                                  }
                      
                                  if (state.editProfileStatus == EditProfileStatus.error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("edit profile Failed")),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  final loading = state.editProfileStatus == EditProfileStatus.loading;
                      
                      
                                  return Center(
                                    child: ButtonWidgets.appButton(
                                      isLoading: loading,

                                      text:   AppLocalizations.of(context)?.translate("editProfile")??"editProfile",

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
                                          // appRoute.go(AppRoutePath.fingerprintScreen.path);
                                          context.read<AuthBloc>().add(
                                            EditProfileEvent(
                                              userModel: UserModel(
                                                fullName: fullNameController.text.trim(),
                                                email: emailController.text.trim(),
                                                mobileNumber: mobileController.text.trim(),
                                                dob: dobController.text.trim(),
                                                password: passwordController.text.trim(),
                                                confirmPassword: confirmPasswordController.text.trim(),
                                                createdAt: state.userModel!.createdAt,
                                                updatedAt: DateTime.now().toString(), role: '', uid: '',
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
                      
                      
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomSize: 14,
      ),
    );
  }
}
