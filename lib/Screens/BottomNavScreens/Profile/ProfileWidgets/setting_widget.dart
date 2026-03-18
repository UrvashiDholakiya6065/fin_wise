import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          // color: ColorsWidgets.mainAppColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: ColorsWidgets.mainAppColor,
              child: Icon(
                icon,
                color: ColorsWidgets.darkGreen,
                size: 20,
              ),
            ),
             SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: FontsWidgets.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontColor: ColorsWidgets.darkGreen
                )
              ),
            ),
             Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: ColorsWidgets.darkGreen,
            ),
          ],
        ),
      ),
    );
  }
}