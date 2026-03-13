import 'package:fin_wise/Bloc/CategorieBloc/categorie_bloc.dart';
import 'package:fin_wise/Bloc/CategorieBloc/categorie_state.dart';
import 'package:fin_wise/Bloc/ExpenseBloc/expense_bloc.dart';
import 'package:fin_wise/Model/expense_model.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Enum/enum.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/TextFields/text_fields.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../AppRoute/app_route.dart';
import '../../../../AppRoute/app_route_path.dart';
import '../../../../SessionManage/shared_pref.dart';
import '../../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import '../../../Search/SearchWidgets/search_transaction_list.dart';

class AddExpenseScreen extends StatefulWidget {
  final String cateId;
  AddExpenseScreen({super.key,required this.cateId});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController dateController = TextEditingController();

  TextEditingController categoriesController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController msgController = TextEditingController();
  // String? selectedCategoryId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        title: "Add Expense",
        backArrow: true,
        centerTitle: true,
      ),
      body: CommonAppUi(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFields.commonTextFormField(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      appRoute.push(AppRoutePath.calenderScreen.path);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: 32,
                        decoration: BoxDecoration(
                          color: ColorsWidgets.mainAppColor,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            ImagesWidget.quicklyAnalysisCalenderImg,
                            height: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  readOnly: true,
                  controller: dateController,
                  labelText: "Date",
                  hintText: "April 30 ,2024",
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2026),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      dateController.text = DateFormat(
                        'MM/dd/yyyy',
                      ).format(pickedDate);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Add Date";
                    }
                    return null;
                  },
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                ),
                SizedBox(height: 19),
                TextFields.commonTextFormField(
                  readOnly: true,
                  hintText: "Select the category",
                  labelText: "Category",
                  controller: categoriesController,
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                  // suffixIcon: Icon(
                  //   Icons.expand_more,
                  //   color: ColorsWidgets.mainAppColor,
                  //   size: 24,
                  // ),
                  suffixIcon: BlocBuilder<CategorieBloc, CategorieState>(
                    builder: (context, state) {
                      final cate = state.categories ?? [];
                      return PopupMenuButton(
                        icon: Icon(
                          Icons.expand_more,
                          color: ColorsWidgets.mainAppColor,
                        ),

                        onSelected: (category) {
                          setState(() {
                            categoriesController.text = category.categorieName;
                            // selectedCategoryId = category.cateId; //

                          });
                        },

                        itemBuilder: (context) {
                          return cate.map((category) {
                            return PopupMenuItem(
                              value: category,
                              child: Text(category.categorieName),
                            );
                          }).toList();
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 19),
                TextFields.commonTextFormField(
                  controller: amountController,
                  labelText: "Amount",
                  hintText: formatAmount(2600),
                  onTap: () async {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Add Amount";
                    }
                    return null;
                  },
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                ),
                SizedBox(height: 19),
                TextFields.commonTextFormField(
                  controller: expenseTitleController,
                  labelText: "Expense Title",
                  hintText: "Dinner",
                  onTap: () async {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Add Expense Title";
                    }
                    return null;
                  },
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                ),
                SizedBox(height: 19),
                TextFields.commonTextFormField(
                  controller: msgController,
                  labelText: "Enter Message",
                  hintText: "Enter Message",
                  readOnly: false,
                  contentHorizontal: 16,
                  contentVertical: 14,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.mainAppColor,
                  // rounded corners
                  maxLine: 4,
                ),
                SizedBox(height: 24),
                BlocConsumer<ExpenseBloc, ExpenseState>(
                  listener: (context, state) {
                    if (state.expenseStatus == ExpenseStatus.success) {
                      // context.read<ExpenseBloc>().add(
                      //   GetExpenseByCategoryEvent(cateId: widget.cateId),
                      // );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Expense added successfully")),
                      );

                      appRoute.pop(true);
                      categoriesController.clear();
                      amountController.clear();
                      expenseTitleController.clear();
                      dateController.clear();
                    }
                  },
                  builder: (context, state) {
                    final loading =
                        state.expenseStatus == ExpenseStatus.loading;
                    return Center(
                      child: ButtonWidgets.appButton(
                        isLoading: loading,
                        text: "Save",
                        onTap: () async {
                          final userId = await SharedPref.getUserUid();

                          context.read<ExpenseBloc>().add(
                            AddExpenseEvent(
                              expenseModel: ExpenseModel(
                                date: dateController.text.trim().toString(),
                                categorie: categoriesController.text.trim(),
                                amount: amountController.text.trim().toString(),
                                expenseTitle: expenseTitleController.text
                                    .trim(),

                                userId:userId.toString(),
                                cateId: widget.cateId, msg: msgController.text.trim(),
                              )
                            ),
                          );


                          // appRoute.push(AppRoutePath.addExpenseScreen.path);
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
              ],
            ),
          ),
        ),
        bottomSize: 16,
      ),
    );
  }
}
