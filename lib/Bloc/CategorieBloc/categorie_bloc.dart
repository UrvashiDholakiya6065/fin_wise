import 'package:bloc/bloc.dart';
import 'package:fin_wise/Model/categorie_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import '../../Model/add_balance_model.dart';
import '../../Network/Repository/repository.dart';
import '../../Utilites/GlobalWidgets/Constant/user_uid.dart';
import 'categorie_state.dart';
part 'categorie_event.dart';

class CategorieBloc extends Bloc<CategorieEvent, CategorieState> {
  final Repository repository;

  CategorieBloc(this.repository) : super(CategorieState()) {
    on<AddCategorieEvent>(addCategorie);
    on<GetCategorieEvent>(getCategories);
  }
    Future<void> addCategorie(AddCategorieEvent event, emit) async {
      emit(state.copyWith(categorieStatus: CategorieStatus.loading));
      try {
        // final uid = FirebaseInstanceClass.auth.currentUser?.uid;
       await repository.addCategories(
          categorieModel: event.categorieModel,
        );
      // print("Add Categories Response::::$response.");

        emit(state.copyWith(categorieStatus: CategorieStatus.success));
      } catch (e) {
        emit(state.copyWith(categorieStatus: CategorieStatus.error));
      }
    }



  Future<void> getCategories(
      GetCategorieEvent event,
      Emitter<CategorieState> emit,
      ) async {

    emit(state.copyWith(categorieStatus: CategorieStatus.loading));

    try {
      // final uid = FirebaseInstanceClass.auth.currentUser!.uid;
      final categories = await repository.getCategories();
      emit(state.copyWith(
        categorieStatus: CategorieStatus.success, categories: categories,
      ));
    } catch (e) {
      emit(state.copyWith(categorieStatus: CategorieStatus.error));
    }
  }
  }

