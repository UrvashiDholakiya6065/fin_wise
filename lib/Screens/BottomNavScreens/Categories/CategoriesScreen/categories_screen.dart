
import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Network/Repository/repository.dart';
import 'package:fin_wise/SessionManage/shared_pref.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/CategorieBloc/categorie_bloc.dart';
import '../../../../Bloc/CategorieBloc/categorie_state.dart';
import '../../../../Bloc/ExpenseBloc/expense_bloc.dart';
import '../../../../Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import '../../../../Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import '../../../../Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import '../../../../Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import '../CategoriesWidgets/categories_widgets.dart';
import '../CategoriesWidgets/show_dialog_box.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    context.read<CategorieBloc>().add(GetCategorieEvent());
    context.read<ExpenseBloc>().add(GetBalanceEvent());



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(

        title:         AppLocalizations.of(context)?.translate("categories")??"categories",

        centerTitle: true,
      ),


      body: CommonAppUi(
        topWidget: BalanceSummeryWidget().balanceSummaryWidget(cateId: "1",storeBalanceInPref: false),

        bottomWidget: BlocBuilder<CategorieBloc, CategorieState>(
          builder: (context, state) {

            final categories = state.categories ?? [];

            return GridView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              itemCount: categories.length + 1,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),

              itemBuilder: (context, index) {

                if (index == categories.length) {
                  return GestureDetector(
                    onTap: () {
                      ShowDialogBox().showAddCategoryDialog(context,null);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 74,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ColorsWidgets.skyBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child:  Icon(Icons.add, size: 30),
                        ),
                         SizedBox(height: 8),
                        Text(
                          "Add",
                          style: FontsWidgets.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontColor: ColorsWidgets.darkGreen,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final category = categories[index];
                // final isSelected = selectedIndex == index;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {

                        appRoute.push(AppRoutePath.categoriesDetailScreen.path,extra: category);
                      },
                      child: Container(
                        width: 74,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                               ColorsWidgets.skyBlue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.asset(
                          ImagesWidget.food,
                          height: 30,
                        ),
                      ),
                    ),
                     SizedBox(height: 8),
                    Text(
                      category.categorieName ,
                      style: FontsWidgets.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontColor: ColorsWidgets.darkGreen,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),

        bottomSize: 4,
      ),
    );
  }
}