
import 'package:equatable/equatable.dart';
import 'package:fin_wise/Model/user_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';

class AuthState extends Equatable {
  final AuthStatus? registrationStatus;
  final BioStatus? biometricStatus;
  final UserModel? userModel;
  final EditProfileStatus? editProfileStatus;
  final ChangePasswordStatus? changePasswordStatus;
  final String? changePasswordError;



  const AuthState({
    this.registrationStatus,
    this.biometricStatus,
    this.userModel,
    this.editProfileStatus,
    this.changePasswordStatus,
    this.changePasswordError

  });

  AuthState copyWith({
    AuthStatus? registrationStatus,
    BioStatus? biometricStatus,
    UserModel? userModel,
    EditProfileStatus? editProfileStatus,
    ChangePasswordStatus? changePasswordStatus,
    String? changePasswordError,

  }) {
    return AuthState(
      registrationStatus: registrationStatus ?? this.registrationStatus,
      biometricStatus: biometricStatus ?? this.biometricStatus,
      userModel: userModel??this.userModel,
      editProfileStatus: editProfileStatus??this.editProfileStatus,
      changePasswordStatus: changePasswordStatus??this.changePasswordStatus,
      changePasswordError: changePasswordError ?? this.changePasswordError,
    );
  }
  @override

  List<Object?> get props => [
    registrationStatus,
    biometricStatus,
    userModel,
    editProfileStatus,
    changePasswordStatus,
    changePasswordError
  ];
}