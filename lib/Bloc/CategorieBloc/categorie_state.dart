import 'package:equatable/equatable.dart';
import 'package:fin_wise/Model/categorie_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';

import '../../Model/add_balance_model.dart';

class CategorieState extends Equatable {
  final CategorieStatus? categorieStatus;

  final List<CategorieModel>? categories;
  const CategorieState({this.categorieStatus, this.categories});

  CategorieState copyWith({
    CategorieStatus? categorieStatus,
    List<CategorieModel>? categories,

  }) {
    return CategorieState(
      categories: categories ?? this.categories,
      categorieStatus: categorieStatus ?? this.categorieStatus,

    );
  }

  @override
  List<Object?> get props => [categorieStatus,categories,];
}
