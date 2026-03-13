

import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class FontsWidgets {
  static TextStyle poppins({double? fontSize, Color? fontColor,FontWeight? fontWeight,  FontStyle? fontStyle,}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: fontColor,
      fontStyle: fontStyle,

    );
  }
  static TextStyle leagueSpartan({double? fontSize, Color? fontColor,FontWeight? fontWeight,double? letterSpacings}) {
    return GoogleFonts.leagueSpartan(
      letterSpacing: letterSpacings,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: fontColor,
    );
  }
  static TextStyle inter({double? fontSize, Color? fontColor,FontWeight? fontWeight,double? letterSpacings}) {
    return GoogleFonts.inter(
      letterSpacing: letterSpacings,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: fontColor,
    );
  }
}