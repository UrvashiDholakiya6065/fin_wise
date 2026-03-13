
import 'package:fin_wise/Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';

import '../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';

final List<Map<String, dynamic>> searchTransactionsList = [

  {
    "icon": ImagesWidget.searchScreenDinnerImg,
    "title": "Dinner",
    "timeDate": "18:27 - April 30",
    "amount": formatAmount(-2600),
    "isExpense": true
  },

];

List<String> categories = [
  "Food",
  "Transport",
  "Medicine",
  "Groceries",
  "Rent",
  "Gifts",
  "Savings",
  "Entertainment",
];