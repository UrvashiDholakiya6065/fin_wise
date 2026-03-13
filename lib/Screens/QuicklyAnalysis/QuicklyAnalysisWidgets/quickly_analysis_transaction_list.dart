
import 'package:fin_wise/Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';

import '../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';

final List<Map<String, dynamic>> transactions = [
  {
    "icon": ImagesWidget.wallet,
    "title": "Salary",
    "timeDate": "18:27 - April 30",
    "category": "Monthly",
    "amount": formatAmount(4000),
    "isExpense": false
  },
  {
    "icon": ImagesWidget.groceriesIcon,
    "title": "Groceries",
    "timeDate": "17:00 - April 24",
    "category": "Pantry",
    "amount": formatAmount(-100),
    "isExpense": true
  },
  {
    "icon": ImagesWidget.rentIcon,
    "title": "Rent",
    "timeDate": "8:30 - April 15",
    "category": "Rent",
    "amount": formatAmount(-67440),
    "isExpense": true
  },
];