part of 'expense_bloc.dart';

class ExpenseState extends Equatable {
  final ExpenseStatus? expenseStatus;
  final List<ExpenseModel>? expenseList;
  final AddBalanceStatus? addBalanceStatus;
  final AddBalanceModel? addBalanceModel;
  final double totalExpense;
  final double remainingBalance;

  const ExpenseState({
    this.expenseStatus,
    this.expenseList,
    this.addBalanceStatus,
    this.addBalanceModel,
    this.totalExpense = 0,
    this.remainingBalance = 0,
  });

  ExpenseState copyWith({
    ExpenseStatus? expenseStatus,
    List<ExpenseModel>? expenseList,
    AddBalanceStatus? addBalanceStatus,
    AddBalanceModel? addBalanceModel,
    final double? totalExpense,
    final double? remainingBalance,
  }) {
    return ExpenseState(
      expenseStatus: expenseStatus ?? this.expenseStatus,
      expenseList: expenseList ?? this.expenseList,
      addBalanceStatus: addBalanceStatus ?? this.addBalanceStatus,
      addBalanceModel: addBalanceModel ?? this.addBalanceModel,
      totalExpense: totalExpense??this.totalExpense,
      remainingBalance: remainingBalance??this.remainingBalance
    );
  }

  @override
  List<Object?> get props => [
    expenseStatus,
    expenseList,
    addBalanceStatus,
    addBalanceModel,
    totalExpense,
    remainingBalance
  ];
}
