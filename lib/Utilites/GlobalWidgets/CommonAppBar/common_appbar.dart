import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonAppbar {

  PreferredSizeWidget commonAppBar({
    String? title,
    String? subtitle,
    bool backArrow=false,
    bool centerTitle=false
  }) {
    return AppBar(
      centerTitle: centerTitle,
      iconTheme: IconThemeData(color: ColorsWidgets.white),
      surfaceTintColor:  ColorsWidgets.mainAppColor,

      automaticallyImplyLeading: backArrow,
      backgroundColor: ColorsWidgets.mainAppColor,
      title: subtitle == null
          ? Text(title ?? "",style: FontsWidgets.poppins(
        fontWeight: FontWeight.w600,
        fontColor: ColorsWidgets.darkGreen,
        fontSize: 14
      ),)
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              title ?? "",
              style:  FontsWidgets.poppins(
                  fontWeight: FontWeight.w600,
                  fontColor: ColorsWidgets.darkGreen,
                  fontSize: 20
              )
          ),
          Text(
              subtitle,
              style:   FontsWidgets.leagueSpartan(
                  fontWeight: FontWeight.w400,
                  fontColor: ColorsWidgets.darkGreen,
                  fontSize: 14
              )
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            notificationWidget(),
            IconButton(onPressed: (){
              appRoute.push("/SuccessfullyPasswordScreen");
            }, icon: Icon(Icons.nature_outlined))

          ],
        )
      ],
    );
  }

  Widget notificationWidget() {
    return GestureDetector(
      onTap: (){
        appRoute.push(AppRoutePath.notificationScreen.path);
      },
      child: Container(
        height: 45,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorsWidgets.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(ImagesWidget.notification,),
          )
      ),
    );
  }

}