
import 'package:equatable/equatable.dart';
import 'package:fin_wise/Model/user_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';

class AuthState extends Equatable {
  final AuthStatus? registrationStatus;
  final BioStatus? biometricStatus;
  final UserModel? userModel;


  const AuthState({
    this.registrationStatus,
    this.biometricStatus,
    this.userModel

  });

  AuthState copyWith({
    AuthStatus? registrationStatus,
    BioStatus? biometricStatus,
    UserModel? userModel

  }) {
    return AuthState(
      registrationStatus: registrationStatus ?? this.registrationStatus,
      biometricStatus: biometricStatus ?? this.biometricStatus,
      userModel: userModel??this.userModel

    );
  }
  @override

  List<Object?> get props => [
    registrationStatus,
    biometricStatus,
    userModel

  ];
}