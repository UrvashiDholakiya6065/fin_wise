
import 'package:equatable/equatable.dart';
import 'package:fin_wise/Model/user_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  final AuthStatus? registrationStatus;
  final BioStatus? biometricStatus;
  final UserModel? userModel;
  final EditProfileStatus? editProfileStatus;
  final ChangePasswordStatus? changePasswordStatus;
  final String? changePasswordError;
  final String selectedRole;
  final ChatListStatus? chatListStatus;
  final List<UserModel> admins;
  final List<UserModel> users;
  final UserModel? currentUser;





  const AuthState({
    this.registrationStatus,
    this.biometricStatus,
    this.userModel,
    this.editProfileStatus,
    this.changePasswordStatus,
    this.changePasswordError,
    this.selectedRole="user",
    this.admins=const [],
    this.users=const [],
    this.chatListStatus,
    this.currentUser


  });

  AuthState copyWith({
    AuthStatus? registrationStatus,
    BioStatus? biometricStatus,
    UserModel? userModel,
    EditProfileStatus? editProfileStatus,
    ChangePasswordStatus? changePasswordStatus,
    String? changePasswordError,
    String? selectedRole,
    List<UserModel>? admins,
    List<UserModel>? users,
    ChatListStatus? chatListStatus,
     UserModel? currentUser,



  }) {
    return AuthState(
      registrationStatus: registrationStatus ?? this.registrationStatus,
      biometricStatus: biometricStatus ?? this.biometricStatus,
      userModel: userModel??this.userModel,
      editProfileStatus: editProfileStatus??this.editProfileStatus,
      changePasswordStatus: changePasswordStatus??this.changePasswordStatus,
      changePasswordError: changePasswordError ?? this.changePasswordError,
      selectedRole: selectedRole??this.selectedRole,
      admins: admins??this.admins,
      users: users??this.users,
      chatListStatus: chatListStatus??this.chatListStatus,
      currentUser: currentUser??this.currentUser
    );
  }
  @override

  List<Object?> get props => [
    registrationStatus,
    biometricStatus,
    userModel,
    editProfileStatus,
    changePasswordStatus,
    changePasswordError,
    selectedRole,
    admins,users,chatListStatus,currentUser
  ];
}