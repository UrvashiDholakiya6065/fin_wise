part of 'expense_bloc.dart';

 class ExpenseState extends Equatable {
   final ExpenseStatus? expenseStatus;
   final List<ExpenseModel>? expenseList;
   final AddBalanceStatus? addBalanceStatus;
   final AddBalanceModel? addBalanceModel;
   const ExpenseState({this.expenseStatus, this.expenseList,this.addBalanceStatus,this.addBalanceModel});

   ExpenseState copyWith({
     ExpenseStatus? expenseStatus,
     List<ExpenseModel>? expenseList,
     AddBalanceStatus? addBalanceStatus,
     AddBalanceModel? addBalanceModel
   }) {
     return ExpenseState(
       expenseStatus: expenseStatus ?? this.expenseStatus,
       expenseList: expenseList ?? this.expenseList,
         addBalanceStatus: addBalanceStatus?? this.addBalanceStatus,
         addBalanceModel: addBalanceModel?? this.addBalanceModel
     );
   }
   @override
List<Object?> get props => [expenseStatus,expenseList,addBalanceStatus,addBalanceModel];
}

