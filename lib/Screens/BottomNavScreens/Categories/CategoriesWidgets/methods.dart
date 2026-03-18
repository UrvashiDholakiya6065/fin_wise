// import 'package:fin_wise/Model/add_balance_model.dart';
//
// import '../../../../Model/expense_model.dart';
//
// class  Methods {
//   double getTotalExpenseByCategory(List<ExpenseModel> expenses, String cateId) {
//     double total = 0;
//
//     for (var expense in expenses) {
//       if (expense.cateId == cateId) {
//         total += double.tryParse(expense.amount) ?? 0;
//       }
//     }
//
//     return total;
//   }
//
//   double getRemainingBalance(
//       AddBalanceModel balanceModel,
//       List<ExpenseModel> expenses,
//       ) {
//
//     double balance = double.tryParse(balanceModel.addBalance) ?? 0;
//
//     double totalExpense = getTotalExpense(expenses);
//
//     return balance - totalExpense;
//   }
// }
import 'package:fin_wise/SessionManage/shared_pref.dart';

import '../../../../Model/add_balance_model.dart';
import '../../../../Model/expense_model.dart';

class Methods {
  double getTotalExpenseByCategory(List<ExpenseModel> expenses, String cateId) {
    double total = 0;
    for (var expense in expenses) {
      if (expense.cateId == cateId) {
        total += double.tryParse(expense.amount) ?? 0;
      }
    }
    return total;
  }

  double getRemainingBalance(
    AddBalanceModel balanceModel,
    List<ExpenseModel> expenses,
    String cateId,
  )  {
    double balance = double.tryParse(balanceModel.addBalance) ?? 0;

    double totalExpense = getTotalExpenseByCategory(expenses, cateId);

    final finalBalance=balance-totalExpense;
    print("final balance in method :$finalBalance");

    return finalBalance;
  }

  double getPercentageBalance(
    AddBalanceModel balanceModel,
    List<ExpenseModel> expenses,
    String cateId,
  ) {
    double balance = double.tryParse(balanceModel.addBalance) ?? 0;

    double totalExpense = getTotalExpenseByCategory(expenses, cateId);

    double remainingBalance = balance - totalExpense;
    print("remanin balance:$remainingBalance");
    print("balance:$balance");
    print("total expense:$totalExpense");
    if (balance == 0) return 0;

    double percentage = (totalExpense / remainingBalance) * 100;
    print("persantage expense:$percentage");

    return percentage;
  }
}
