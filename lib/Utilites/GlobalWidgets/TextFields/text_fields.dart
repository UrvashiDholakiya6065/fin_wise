import 'package:flutter/material.dart';

import '../Colors/colors_widgets.dart';
import '../Fonts/fonts_widgets.dart';

class TextFields {
  static Widget commonTextFormField({
    required TextEditingController controller,
    String? hintText,
    String? labelText,
    bool obscureText = false,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    VoidCallback? onTap,
    int? maxLine,
    required double contentHorizontal,
    required double contentVertical,
    required Color fillColor,
    required Color hintFontColor,


  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              labelText,
                       style: FontsWidgets.poppins(
                  fontColor: ColorsWidgets.darkGreen,
                  fontWeight: FontWeight.w500,
                ),
            ),
          ),
        SizedBox(height: 8,),
        TextFormField(
          maxLines: obscureText ? 1 : maxLine,

          onTap: onTap,
          readOnly: readOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style:  FontsWidgets.poppins(
            fontColor: ColorsWidgets.darkGreen,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle:  FontsWidgets.poppins(
              fontColor: hintFontColor,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor,
            contentPadding:  EdgeInsets.symmetric(
              horizontal: contentHorizontal,
              vertical: contentVertical,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}