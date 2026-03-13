
import 'package:fin_wise/Utilites/GlobalWidgets/MediaQuery/media_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';


// final List<Map<String, dynamic>> categoriesTransacationList = [
//   {
//     "icon": ImagesWidget.wallet,
//     "title": "Salary",
//     "timeDate": "18:27 - April 30",
//     "category": "Monthly",
//     "amount": formatAmount(4000),
//     "isExpense": false
//   },
//   {
//     "icon": ImagesWidget.groceriesIcon,
//     "title": "Groceries",
//     "timeDate": "17:00 - April 24",
//     "category": "Pantry",
//     "amount":  formatAmount(-100),
//     "isExpense": true
//   },
//   {
//     "icon": ImagesWidget.rentIcon,
//     "title": "Rent",
//     "timeDate": "8:30 - April 15",
//     "category": "Rent",
//     "amount":  formatAmount(-67440),
//     "isExpense": true
//   },
// ];

final List<Map<String, dynamic>> categoriesTransacationList = [
  {
    "icon": ImagesWidget.food,
    "title": "Dinner",
    "timeDate": "18:27 - April 30",
    "amount": formatAmount(-26.00),
    "isExpense": true
  },
  {
    "icon": ImagesWidget.food,
    "title": "Delivery Pizza",
    "timeDate": "15:00 - April 24",
    "amount": formatAmount(-18.35),
    "isExpense": true
  },
  {
    "icon": ImagesWidget.food,
    "title": "Lunch",
    "timeDate": "12:30 - April 15",
    "amount": formatAmount(-15.40),
    "isExpense": true
  },
  {
    "icon": ImagesWidget.food,
    "title": "Brunch",
    "timeDate": "9:30 - April 08",
    "amount": formatAmount(-12.13),
    "isExpense": true
  },
  // {
  //   "icon": ImagesWidget.food,
  //   "title": "Dinner",
  //   "timeDate": "20:50 - March 31",
  //   "amount": formatAmount(-27.20),
  //   "isExpense": true
  // },
];