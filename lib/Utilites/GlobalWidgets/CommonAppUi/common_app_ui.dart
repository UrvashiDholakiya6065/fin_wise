

import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:flutter/material.dart';

class CommonAppUi extends StatelessWidget {
  final Widget? topWidget;
  final Widget bottomWidget;
  final int bottomSize;

  const CommonAppUi({
    super.key,
     this.topWidget,
    required this.bottomWidget, required this.bottomSize
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsWidgets.mainAppColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(child: topWidget),
            ),

            Expanded(
              flex: bottomSize,
              child: Container(

                width: double.infinity,
                // padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  color: ColorsWidgets.lightWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: bottomWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}