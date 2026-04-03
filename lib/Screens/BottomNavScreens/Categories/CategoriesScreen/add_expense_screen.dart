import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_wise/Bloc/CategorieBloc/categorie_bloc.dart';
import 'package:fin_wise/Bloc/CategorieBloc/categorie_state.dart';
import 'package:fin_wise/Bloc/ExpenseBloc/expense_bloc.dart';
import 'package:fin_wise/Model/expense_model.dart';
import 'package:fin_wise/Screens/BottomNavScreens/Categories/CategoriesWidgets/methods.dart';
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
import '../../../../Bloc/NotificatioBloc/notification_bloc.dart';
import '../../../../Model/notification_model.dart';
import '../../../../Network/Services/notification_service.dart';
import '../../../../SessionManage/shared_pref.dart';
import '../../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/Texts/language_controller.dart';

class AddExpenseScreen extends StatefulWidget {
  final String cateId;
  final TextEditingController categoryController;

  AddExpenseScreen({
    super.key,
    required this.cateId,
    required this.categoryController,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController dateController = TextEditingController();

  // TextEditingController categoriesController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Methods methods = Methods();
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
                  controller: widget.categoryController,
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                ),

                SizedBox(height: 19),
                TextFields.commonTextFormField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  labelText: "Amount",
                  hintText: formatAmount(2600,context),
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
                  listener: (context, state) async {
                    if (state.expenseStatus == ExpenseStatus.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Expense added successfully")),
                      );

                      appRoute.pop(true);
                      widget.categoryController.clear();
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
                        final double currentBalance = await SharedPref.getBalance() ?? 0;
                        print("Current balance :::$currentBalance");
                        final double newExpenseAmount = double.tryParse(amountController.text.trim()) ?? 0;
                          print("New balance :::$newExpenseAmount");


                        if (newExpenseAmount < currentBalance) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Not enough balance!")),
                          );
                          return;
                        }

                        final double remainingBalance = currentBalance - newExpenseAmount;
                          print("minus balance :::$remainingBalance");


                        await SharedPref.setBalance(balance: remainingBalance);
                          context.read<ExpenseBloc>().add(
                            AddExpenseEvent(
                              expenseModel: ExpenseModel(
                                date: dateController.text.trim().toString(),
                                categorie: widget.categoryController.text
                                    .trim(),
                                amount: amountController.text.trim().toString(),
                                expenseTitle: expenseTitleController.text
                                    .trim(),

                                userId: userId.toString(),
                                cateId: widget.cateId,
                                msg: msgController.text.trim(),
                              ),
                            ),
                          );

                          final notification = NotificationModel(
                            title: "Expense",

                             body: "Remaining Balance $remainingBalance",
                            timestamp: DateTime.now(),
                          );

                          NotificationService.showLocalNotificationFromData({
                            "title": notification.title,
                            "body": notification.body,
                          });

                          context.read<NotificationBloc>().add(
                            AddNotificationEvent(notificationModel: notification),
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
