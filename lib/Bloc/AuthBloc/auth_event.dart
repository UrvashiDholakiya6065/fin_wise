
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