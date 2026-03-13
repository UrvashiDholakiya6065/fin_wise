class ExpenseModel {
  final String date;
  final String categorie;
  final String amount;
  final String expenseTitle;
  final String userId;
  final String cateId;
  final String msg;
  ExpenseModel({
    required this.date,
    required this.categorie,
    required this.amount,
    required this.expenseTitle,
    required this.userId,
    required this.cateId,
    required this.msg
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      date: json['date'],
      categorie: json['categorie'],
      amount: json['amount'],
      expenseTitle: json['expenseTitle'],
      userId: json['userId'],
      cateId: json['cateId'],
      msg: json['msg']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'categorie': categorie,
      'amount': amount,
      'expenseTitle': expenseTitle,
      'userId':userId,
      'cateId': cateId,
      'msg':msg
    };
  }
}
