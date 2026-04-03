import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fin_wise/Model/expense_model.dart';
import 'package:fin_wise/Network/Repository/repository.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';

import '../../Model/add_balance_model.dart';

part 'expense_event.dart';

part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  Repository repository;

  ExpenseBloc(this.repository) : super(ExpenseState()) {
    on<AddExpenseEvent>(addExpenseBloc);
    on<GetExpenseByCategoryEvent>(getExpenseByCategoryBloc);
    on<AddBalanceEvent>(addBalanceBloc);
    on<GetBalanceEvent>(getBalanceBloc);

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
  // Future<void> addBalanceBloc(AddBalanceEvent event, emit) async {
  //   emit(state.copyWith(addBalanceStatus: AddBalanceStatus.loading));
  //   try {
  //     double currentBalance = 0;
  //
  //     currentBalance = double.tryParse(
  //         state.addBalanceModel!.addBalance.replaceAll(",", "")) ?? 0;
  //
  //
  //   double newBalance = double.tryParse(event.addBalanceModel.addBalance.replaceAll(",", "")) ?? 0;
  //
  //   double totalBalance = currentBalance + newBalance;
  //
  //   final updatedBalance = AddBalanceModel(
  //       addBalance: totalBalance.toString(),
  //       userId: event.addBalanceModel.userId,
  //     );
  //
  //     await repository.addBalance(addBalanceModel: updatedBalance);
  //     await repository.addBalance(
  //         addBalanceModel: event.addBalanceModel
  //     );
  //     // print("Add Categories Response::::$response.");
  //
  //     emit(state.copyWith(addBalanceStatus: AddBalanceStatus.success));
  //   } catch (e) {
  //     emit(state.copyWith(addBalanceStatus: AddBalanceStatus.error));
  //   }
  // }

  Future<void> addBalanceBloc(AddBalanceEvent event, Emitter<ExpenseState> emit) async {
    emit(state.copyWith(addBalanceStatus: AddBalanceStatus.loading));
    try {
      double currentBalance = 0;
      if (state.addBalanceModel != null) {
        currentBalance = double.tryParse(
            state.addBalanceModel!.addBalance.replaceAll(",", "")) ?? 0;
      }

      double newBalance = double.tryParse(
          event.addBalanceModel.addBalance.replaceAll(",", "")) ?? 0;

      double totalBalance = currentBalance + newBalance;

      final updatedBalance = AddBalanceModel(
        addBalance: totalBalance.toString(),
        userId: event.addBalanceModel.userId,
      );

      await repository.addBalance(addBalanceModel: updatedBalance);

      emit(state.copyWith(
        addBalanceStatus: AddBalanceStatus.success,
        addBalanceModel: updatedBalance,
      ));
    } catch (e) {
      print("AddBalance Error: $e");
      emit(state.copyWith(addBalanceStatus: AddBalanceStatus.error));
    }
  }
  Future<void> getBalanceBloc(
      GetBalanceEvent event,
      Emitter<ExpenseState> emit,
      ) async {

    emit(state.copyWith(addBalanceStatus: AddBalanceStatus.loading));

    try {

      final balance = await repository.getBalance();

      emit(state.copyWith(
        addBalanceStatus: AddBalanceStatus.success,
        addBalanceModel: balance,
      ));

    } catch (e) {

      emit(state.copyWith(addBalanceStatus: AddBalanceStatus.error));

    }
  }


}
