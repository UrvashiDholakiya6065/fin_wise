class UserModel {
  final String fullName;
  final String email;
  final String mobileNumber;
  final String dob;
  final String password;
  final String confirmPassword;
  final String createdAt;
  final String updatedAt;
  final String role;
  final String uid;

  UserModel({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.dob,
    required this.password,
    required this.confirmPassword,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.uid,
  });

  /// ✅ FROM JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      mobileNumber: json['mobileNumber'] ?? "",
      dob: json['dob'] ?? "",
      password: json['password'] ?? "",
      confirmPassword: json['confirmPassword'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      role: json['role'] ?? "",
      uid: json['uid'] ?? "",
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
      "role": role,
      "uid": uid,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? email,
    String? mobileNumber,
    String? dob,
    String? password,
    String? confirmPassword,
    String? createdAt,
    String? updatedAt,
    String? role,
    String? uid,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      dob: dob ?? this.dob,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role ?? this.role,
      uid: uid ?? this.uid,
    );
  }
}