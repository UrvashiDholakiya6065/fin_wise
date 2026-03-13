import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState(0)) {
    on<ChangeIndexEvent>(changeIndexBloc);

    on<NextEvent>(changeNextBloc);
  }
  void changeIndexBloc(ChangeIndexEvent event,emit){
    emit(OnboardingState(event.index));
  }
  void changeNextBloc(NextEvent event,emit){
    if (state.index < 1) {
      emit(OnboardingState(state.index + 1));
    }
  }
}