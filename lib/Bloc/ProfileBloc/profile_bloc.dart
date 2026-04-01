import 'package:fin_wise/Bloc/ProfileBloc/profile_event.dart';
import 'package:fin_wise/Bloc/ProfileBloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Network/TranslateRepo/transalre_repo.dart';
import '../../Utilites/GlobalWidgets/Enum/enum.dart';
import '../AuthBloc/auth_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc authBloc;

  ProfileBloc({required this.authBloc}) : super( ProfileState()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<TranslateNameEvent>(_onTranslateName);
  }

  Future<void> _onLoadProfile(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final user = authBloc.state.userModel;
      if (user != null) {
        emit(state.copyWith(
          userName: user.fullName,
          email: user.email ?? "",
          profileStatus: ProfileStatus.success,
        ));

        add(TranslateNameEvent(user.fullName, event.lang));
      } else {
        emit(state.copyWith(profileStatus: ProfileStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error));
    }
  }

  Future<void> _onTranslateName(
      TranslateNameEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      if (event.name.isEmpty) {
        emit(state.copyWith(profileStatus: ProfileStatus.error));
        return;
      }

      if (event.lang == 'en') {
        emit(state.copyWith(
            translatedName: event.name, profileStatus: ProfileStatus.success));
        return;
      }

      final translated = await TranslationService.translate(event.name, event.lang);

      emit(state.copyWith(
        translatedName: translated,
        profileStatus: ProfileStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error));
    }
  }
}