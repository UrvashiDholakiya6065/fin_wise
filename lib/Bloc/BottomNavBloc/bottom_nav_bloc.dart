import 'package:fin_wise/Bloc/OnboardingBloc/onboarding_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

class BottomNavigationBloc extends Bloc<ChangeTabEvent, BottomNavState> {

  BottomNavigationBloc() : super(BottomNavState(0)) {

    on<ChangeTabEvent>(changeTabBloc);

  }
  void  changeTabBloc(ChangeTabEvent event,emit){
    emit(BottomNavState(event.index));
  }
}