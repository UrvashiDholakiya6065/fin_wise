import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Network/Services/notification_service.dart';
import '../../SessionManage/shared_pref.dart';
import '../../Utilites/GlobalWidgets/BiomatricService/biomatric_service.dart';
import '../../Utilites/GlobalWidgets/PngImages/images_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    check();
    NotificationService.init();

  }


  Future<void> check() async {

    final token = await SharedPref.getUserIdAccessToken();
    final biometric = await SharedPref.getBiometricEnable();

    await Future.delayed(const Duration(seconds: 2));

    if (token == null) {
      appRoute.go(AppRoutePath.loginScreen.path);

    }
    else if (biometric) {

      await SharedPref.setFromSplash(true);

      appRoute.go(AppRoutePath.fingerprintScreen.path);

    }
    else {

      appRoute.go(AppRoutePath.homeScreen.path);

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsWidgets.mainAppColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              ImagesWidget.commonAppImage,
              width: 109,
              height: 114,
            ),
          ),
          SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)?.translate("fineWise")??"fineWise",

            style: FontsWidgets.poppins(
              fontColor: ColorsWidgets.white,
              fontSize: 50,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
