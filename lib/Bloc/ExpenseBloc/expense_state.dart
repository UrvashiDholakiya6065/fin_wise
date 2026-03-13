part of 'expense_bloc.dart';

 class ExpenseState extends Equatable {
   final ExpenseStatus? expenseStatus;
   final List<ExpenseModel>? expenseList;
   const ExpenseState({this.expenseStatus, this.expenseList});

   ExpenseState copyWith({
     ExpenseStatus? expenseStatus,
     List<ExpenseModel>? expenseList,
   }) {
     return ExpenseState(
       expenseStatus: expenseStatus ?? this.expenseStatus,
       expenseList: expenseList ?? this.expenseList,
     );
   }
   @override
List<Object?> get props => [expenseStatus,expenseList];
}

