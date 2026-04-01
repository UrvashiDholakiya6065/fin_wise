


import 'package:equatable/equatable.dart';

import '../../Utilites/GlobalWidgets/Enum/enum.dart';

class ProfileState extends Equatable {
  final String userName;
  final String translatedName;
  final String email;
  final ProfileStatus? profileStatus;

  const ProfileState({
    this.userName = "",
    this.translatedName = "",
    this.email = "",
    this.profileStatus
  });

  ProfileState copyWith({
    String? userName,
    String? translatedName,
    String? email,
    ProfileStatus? profileStatus,
  }) {
    return ProfileState(
      userName: userName ?? this.userName,
      translatedName: translatedName ?? this.translatedName,
      email: email ?? this.email,
      profileStatus: profileStatus ?? this.profileStatus
    );
  }

  @override
  List<Object?> get props => [userName, translatedName, email,profileStatus];
}