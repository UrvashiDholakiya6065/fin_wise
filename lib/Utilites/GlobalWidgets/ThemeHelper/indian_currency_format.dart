// // import 'package:intl/intl.dart';
// //
// // String formatAmount(double amount) {
// //
// //   final formatter = NumberFormat.currency(
// //     locale: 'en_IN',
// //     symbol: '₹ ',
// //
// //      decimalDigits: 2,
// //   );
// //   return formatter.format(amount);
// // }
// //
//
// import 'package:intl/intl.dart';
// import '../Texts/language_controller.dart';
//
// String formatAmount(double amount) {
//   final formatter = NumberFormat("#,##0.00", "en_IN");
//
//   String result = "₹ ${formatter.format(amount)}";
//
//   if (LanguageController.currentLang == 'gujarati') {
//     result = result
//         .replaceAll('0', '૦')
//         .replaceAll('1', '૧')
//         .replaceAll('2', '૨')
//         .replaceAll('3', '૩')
//         .replaceAll('4', '૪')
//         .replaceAll('5', '૫')
//         .replaceAll('6', '૬')
//         .replaceAll('7', '૭')
//         .replaceAll('8', '૮')
//         .replaceAll('9', '૯');
//   }
//
//   else if (LanguageController.currentLang == 'hindi') {
//     result = result
//         .replaceAll('0', '०')
//         .replaceAll('1', '१')
//         .replaceAll('2', '२')
//         .replaceAll('3', '३')
//         .replaceAll('4', '४')
//         .replaceAll('5', '५')
//         .replaceAll('6', '६')
//         .replaceAll('7', '७')
//         .replaceAll('8', '८')
//         .replaceAll('9', '९');
//   }
//
//   return result;
// }

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String formatAmount(double amount, BuildContext context) {
  final formatter = NumberFormat("#,##0.00", "en_IN");
  String result = "₹ ${formatter.format(amount)}";

  final localeCode = Localizations.localeOf(context).languageCode;

  if (localeCode == 'gu') {
    // Gujarati digits
    result = result
        .replaceAll('0', '૦')
        .replaceAll('1', '૧')
        .replaceAll('2', '૨')
        .replaceAll('3', '૩')
        .replaceAll('4', '૪')
        .replaceAll('5', '૫')
        .replaceAll('6', '૬')
        .replaceAll('7', '૭')
        .replaceAll('8', '૮')
        .replaceAll('9', '૯');
  } else if (localeCode == 'hi') {
    // Hindi digits
    result = result
        .replaceAll('0', '०')
        .replaceAll('1', '१')
        .replaceAll('2', '२')
        .replaceAll('3', '३')
        .replaceAll('4', '४')
        .replaceAll('5', '५')
        .replaceAll('6', '६')
        .replaceAll('7', '७')
        .replaceAll('8', '८')
        .replaceAll('9', '९');
  }

  return result;
}