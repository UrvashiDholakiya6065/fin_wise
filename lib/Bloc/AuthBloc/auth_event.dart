
import 'package:fin_wise/Model/login_model.dart';

import '../../Model/user_model.dart';

class AuthEvent {}


class SignupEvent extends AuthEvent{
  final UserModel userModel;

   SignupEvent({required this.userModel});
}


class LoginEvent extends AuthEvent {

  final LoginModel loginModel;

  LoginEvent({
    required this.loginModel
  });
}


class LoginWithBiometricEvent extends AuthEvent {}
class FetchUserEvent extends AuthEvent {}
class LogoutEvent extends AuthEvent {}
class EditProfileEvent extends AuthEvent {
  final UserModel userModel;

  EditProfileEvent({required this.userModel});
}
class ChangePasswordEvent extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });
}

class SelectRoleEvent extends AuthEvent {
  final String role;

  SelectRoleEvent({required this.role});
}
class LoadChatListEvent extends AuthEvent{}
