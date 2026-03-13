import 'package:flutter/material.dart';

class AppSize {
  static double hight(BuildContext context) => MediaQuery.of(context).size.height;

  static double widht(BuildContext context) =>
      MediaQuery.of(context).size.width;
}