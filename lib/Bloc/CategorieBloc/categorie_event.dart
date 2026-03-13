part of 'categorie_bloc.dart';

class CategorieEvent {}

class AddCategorieEvent extends CategorieEvent {
  final CategorieModel categorieModel;

  AddCategorieEvent({required this.categorieModel});
}

class GetCategorieEvent extends CategorieEvent {}
