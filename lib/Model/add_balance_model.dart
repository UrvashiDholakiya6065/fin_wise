class AddBalanceModel {
  final String addBalance;
  final String userId;

  AddBalanceModel({required this.addBalance,required this.userId,});


  factory AddBalanceModel.fromJson(Map<String, dynamic> json) {
    return AddBalanceModel(
      addBalance: json['addBalance'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "addBalance": addBalance,
      "userId": userId,
    };
  }
}