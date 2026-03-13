class CategorieModel {
  final String categorieName;
  final String userId;
  final String cateId;


  CategorieModel({
    required this.categorieName,
    required this.userId,
    required this.cateId
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
    return CategorieModel(
     categorieName: json['categorieName'],
      userId: json['userId'],
      cateId: json['cateId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
    "categorieName":categorieName,
      "userId":userId,
      "cateId":cateId
    };
  }
}