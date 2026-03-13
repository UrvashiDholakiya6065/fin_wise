
import 'package:fin_wise/Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';

import '../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';

final List<Map<String, dynamic>> transactionsLists = [

  {
    "icon": ImagesWidget.groceriesIcon,
    "title": "Groceries",
    "timeDate": "17:00 - April 24",
    "category": "Pantry",
    "amount": formatAmount(-100),
    "isExpense": true
  },
  {
    "icon": ImagesWidget.wallet,
    "title": "Others",
    "timeDate": "17:00 - April 24",
    "category": "Payments",
    "amount": formatAmount(12000),
    "isExpense": false
  },
];