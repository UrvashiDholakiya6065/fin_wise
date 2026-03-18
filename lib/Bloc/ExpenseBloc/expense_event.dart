part of 'expense_bloc.dart';

 class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
 final ExpenseModel expenseModel;

 AddExpenseEvent({required this.expenseModel});
}
class GetExpenseByCategoryEvent extends ExpenseEvent {
 final String cateId;

 GetExpenseByCategoryEvent({required this.cateId});
}
class AddBalanceEvent extends ExpenseEvent{
 final AddBalanceModel addBalanceModel;

 AddBalanceEvent({required this.addBalanceModel});
}

class GetBalanceEvent extends ExpenseEvent{}

