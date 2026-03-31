// import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
// import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
// import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
// import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class SuccessfullyPasswordScreen extends StatelessWidget {
//   const SuccessfullyPasswordScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorsWidgets.mainAppColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(child: Image.asset(ImagesWidget.progress,height: 142,)),
//           SizedBox(height: 32,),
//           Text(TextsWidgets.successfullyChangePassword,style: FontsWidgets.poppins(
//             fontColor: ColorsWidgets.lightGreen,
//             fontWeight: FontWeight.w600
//           ),)
//         ],
//       ),
//     );
//   }
// }
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:flutter/material.dart';

class SuccessfullyPasswordScreen extends StatefulWidget {
  const SuccessfullyPasswordScreen({super.key});
  @override
  State<SuccessfullyPasswordScreen> createState() =>
      _SuccessfullyPasswordScreenState();
}
class _SuccessfullyPasswordScreenState
    extends State<SuccessfullyPasswordScreen> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsWidgets.mainAppColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isVisible ? 1 : 0,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Center(
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            AnimatedOpacity(
              opacity: isVisible ? 1 : 0,
              duration: Duration(milliseconds: 800),
              child: Text(
                "Pin Has Been\nChanged Successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}