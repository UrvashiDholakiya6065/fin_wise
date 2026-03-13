class UserModel {
  final String fullName;
  final String email;
  final String mobileNumber;
  final String dob;
  final String password;
  final String confirmPassword;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.dob,
    required this.password,
    required this.confirmPassword,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'] ,
      dob: json['dob'],
      password: json['password'],
      confirmPassword: json['confirmPassword'] ,
      createdAt: json['createdAt'] ,
      updatedAt: json['updatedAt'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "mobileNumber": mobileNumber,
      "dob": dob,
      "password": password,
      "confirmPassword": confirmPassword,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}