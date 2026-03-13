import 'package:fin_wise/Bloc/CategorieBloc/categorie_bloc.dart';
import 'package:fin_wise/Bloc/CategorieBloc/categorie_state.dart';
import 'package:fin_wise/Model/categorie_model.dart';
import 'package:fin_wise/SessionManage/shared_pref.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../AppRoute/app_route.dart';
import '../../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../../../Utilites/GlobalWidgets/Enum/enum.dart';

class ShowDialogBox {
  void showAddCategoryDialog(BuildContext context,cateId) {
    TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "New Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(
                      hintText: "Write...",
                      filled: true,
                      fillColor: Colors.green.withOpacity(0.15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  BlocConsumer<CategorieBloc, CategorieState>(
                    listener: (context, state) {
                      if (state.categorieStatus == CategorieStatus.success) {
                        appRoute.pop();
                      }

                      if (state.categorieStatus == CategorieStatus.error) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Error")));
                      }
                    },
                    builder: (context, state) {
                      // if (state.categorieStatus == CategorieStatus.loading) {
                      //   return CircularProgressIndicator();
                      // }

                      return Center(
                        child: ButtonWidgets.appButton(
                          text: "Save",
                          onTap: () async {
                            context.read<CategorieBloc>().add(
                              AddCategorieEvent(
                                categorieModel: CategorieModel(
                                  categorieName: categoryController.text.trim(),
                                  userId:
                                      (await SharedPref.getUserUid()) ??
                                      "unknown_user", cateId:cateId??"" ,
                                ),
                              ),
                            );
                            appRoute.pop();
                            context.read<CategorieBloc>().add(
                              GetCategorieEvent(),
                            );

                            String category = categoryController.text;

                            print(category);
                          },
                          backgroundColor: ColorsWidgets.mainAppColor,
                          height: 45,
                          width: 207,
                          textColor: ColorsWidgets.darkGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 10),
                  Center(
                    child: ButtonWidgets.appButton(
                      text: "Cancel",
                      onTap: () {
                        appRoute.pop();
                      },
                      backgroundColor: ColorsWidgets.lightGreen,
                      height: 45,
                      width: 207,
                      textColor: ColorsWidgets.darkGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
