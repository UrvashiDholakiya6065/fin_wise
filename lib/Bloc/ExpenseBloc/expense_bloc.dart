import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_wise/Model/expense_model.dart';
import 'package:fin_wise/Network/Repository/repository.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';

part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  Repository repository;

  ExpenseBloc(this.repository) : super(ExpenseState()) {
    on<AddExpenseEvent>(addExpenseBloc);
    on<GetExpenseByCategoryEvent>(getExpenseByCategoryBloc);
  }

  Future<void> addExpenseBloc(AddExpenseEvent event, emit) async {
    emit(state.copyWith(expenseStatus: ExpenseStatus.loading));
    try {
      await repository.addExpense(expenseModel: event.expenseModel);

      emit(state.copyWith(expenseStatus: ExpenseStatus.success));
    } catch (e) {
      emit(state.copyWith(expenseStatus: ExpenseStatus.error));
    }
  }
  Future<void> getExpenseByCategoryBloc(
      GetExpenseByCategoryEvent event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(expenseStatus: ExpenseStatus.loading));

    try {
      final expenses =
      await repository.getExpensesByCategory(event.cateId);

      emit(state.copyWith(
        expenseStatus: ExpenseStatus.success,
        expenseList: expenses,
      ));
    } catch (e) {
      emit(state.copyWith(expenseStatus: ExpenseStatus.error));
    }
  }
}
