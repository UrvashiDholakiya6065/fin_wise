import 'package:fin_wise/Bloc/AuthBloc/auth_bloc.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_event.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Buttons/TextButtons/text_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../AppRoute/app_route.dart';
import '../../AppRoute/app_route_path.dart';
import '../../SessionManage/shared_pref.dart';
import '../../Utilites/GlobalWidgets/BiomatricService/biomatric_service.dart';
import '../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../Utilites/GlobalWidgets/Enum/enum.dart';
import '../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';

class FingerprintScreen extends StatefulWidget {

  const FingerprintScreen({super.key});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  bool fromSplash = false;

  // @override
  // void initState() {
  //   super.initState();
  //   load();
  // }

  // Future<void> load() async {
  //   fromSplash = await SharedPref.getFromSplash();
  //   setState(() {});
  // }
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    fromSplash = await SharedPref.getFromSplash();

    if (mounted) {
      setState(() {});
    }

    if (fromSplash) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (mounted) {
          context.read<AuthBloc>().add(LoginWithBiometricEvent());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonAppUi(
            topWidget: Text(
              TextsWidgets.securityFingerprint,
              style: FontsWidgets.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                fontColor: ColorsWidgets.darkGreen,
              ),
            ),
            bottomWidget: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 14),
                  child: Column(
                      children: [
                      SizedBox(height: 42),
                  Image.asset(ImagesWidget.fingerPrint, height: 185),
                  SizedBox(height: 24),
                  Text(
                    TextsWidgets.useFingerprintToAccess,
                    style: FontsWidgets.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      fontColor: ColorsWidgets.darkGreen,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    TextsWidgets.fingerprintDis,
                    style: FontsWidgets.leagueSpartan(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontColor: ColorsWidgets.darkGreen,
                    ),
                  ),
                  SizedBox(height: 65),
                  // BlocConsumer<AuthBloc, AuthState>(
                  //   listener: (context, state) {
                  //     if (state.biometricStatus == BioStatus.success) {
                  //       appRoute.go(AppRoutePath.homeScreen.path);
                  //     } else if (state.biometricStatus == BioStatus.error) {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text("Biometric failed!")),
                  //       );
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     return ButtonWidgets.appButton(
                  //       text: TextsWidgets.useTouchId,
                  //       onTap: () async {
                  //
                  //         context.read<AuthBloc>().add(LoginWithBiometricEvent());
                  //         // appRoute.push(AppRoutePath.homeScreen.path);
                  //       },
                  //       backgroundColor: ColorsWidgets.lightGreen,
                  //       height: 40,
                  //       width: double.infinity,
                  //       textColor: ColorsWidgets.darkGreen,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.w600,
                  //     );
                  //   },
                  // ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) async {
                      if (state.biometricStatus == BioStatus.success) {


                        await SharedPref.setBiometricEnable(true);

                        appRoute.go(AppRoutePath.homeScreen.path);

                        // }
                      } else if (state.biometricStatus == BioStatus.error) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Biometric failed!")),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ButtonWidgets.appButton(
                        text: TextsWidgets.useTouchId,
                        onTap: () {
                          context.read<AuthBloc>().add(
                              LoginWithBiometricEvent());
                        },
                        backgroundColor: ColorsWidgets.lightGreen,
                        height: 40,
                        width: double.infinity,
                        textColor: ColorsWidgets.darkGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      );
                    },
                  ),
                  SizedBox(height: 6,),
                  // TextButtons.textButton(
                  //   text: "Skip",
                  //   onTap: () async {
                  //     SharedPref.setBiometricEnable(false);
                  //     appRoute.pushReplacement(AppRoutePath.homeScreen.path);
                  //
                  //   },
                  // ),
                  if (!fromSplash)
              ButtonWidgets.appButton(
              text: "Skip",
              onTap: () async {
                await SharedPref.setBiometricEnable(false);

                appRoute.go(AppRoutePath.homeScreen.path);
              },
              backgroundColor: ColorsWidgets.lightGreen,
              height: 40,
              width: double.infinity,
              textColor: ColorsWidgets.darkGreen,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),


            SizedBox(height: 24,),
          TextButtons.textButton(
              text: TextsWidgets.preferUsePinCode,
              onTap: () {},
              textStyle: FontsWidgets.leagueSpartan(
                  fontColor: ColorsWidgets.darkGreen,
                  fontWeight: FontWeight.w300

              )
          ),
        ],
      ),
    ),
    ),
    bottomSize: 6,
    ),
    ],
    )
    ,
    );
  }
}
