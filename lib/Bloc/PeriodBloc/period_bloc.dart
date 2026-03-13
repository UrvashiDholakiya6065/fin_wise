import 'package:fin_wise/Bloc/PeriodBloc/period_event.dart';
import 'package:fin_wise/Bloc/PeriodBloc/period_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeriodBloc extends Bloc<ChangePeriodEvent, PeriodState> {
  PeriodBloc() : super(PeriodState("Monthly")) {
    on<ChangePeriodEvent>((event, emit) {
      emit(PeriodState(event.period));
    });
  }
}

