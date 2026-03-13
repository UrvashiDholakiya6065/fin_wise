import 'package:fin_wise/Screens/Search/SearchWidgets/search_transaction_item.dart';
import 'package:fin_wise/Screens/Search/SearchWidgets/search_transaction_list.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Colors/colors_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Fonts/fonts_widgets.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/PngImages/images_widget.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/texts_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Utilites/GlobalWidgets/Buttons/CustomButtons/button_widgets.dart';
import '../../../Utilites/GlobalWidgets/Buttons/ElevatedButton/elevated_buttons.dart';
import '../../../Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import '../../../Utilites/GlobalWidgets/TextFields/text_fields.dart';
import '../SearchWidgets/search_transaction_item.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  TextEditingController categoriesController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar().commonAppBar(
        centerTitle: true,
        backArrow: true,
        title: TextsWidgets.searchScreenTitle,
      ),
      body: CommonAppUi(
        topWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextFields.commonTextFormField(
            controller: searchController,
            hintText: TextsWidgets.searchScreenSearch,
            contentHorizontal: 20,
            contentVertical: 7,
            fillColor: ColorsWidgets.white,
            hintFontColor: ColorsWidgets.black,
          ),
        ),

        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFields.commonTextFormField(
                  hintText: TextsWidgets.searchScreenHintText,
                  labelText: TextsWidgets.searchScreenLableCategories,
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
                  suffixIcon: PopupMenuButton(
                    icon: Icon(
                      Icons.expand_more,
                      color: ColorsWidgets.mainAppColor,
                    ),

                    onSelected: (value) {
                      setState(() {
                        categoriesController.text = value;
                      });
                    },

                    itemBuilder: (context) {
                      return categories.map((category) {
                        return PopupMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList();
                    },
                  ),
                ),
                SizedBox(height: 30),
                TextFields.commonTextFormField(
                  readOnly: true,
                  hintText: TextsWidgets.searchScreenHintTextDate,
                  labelText: TextsWidgets.searchScreenLableDate,
                  controller: dateController,
                  contentHorizontal: 20,
                  contentVertical: 10,
                  fillColor: ColorsWidgets.lightGreen,
                  hintFontColor: ColorsWidgets.darkGreen.withOpacity(0.34),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: ColorsWidgets.mainAppColor,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          ImagesWidget.quicklyAnalysisCalenderImg,
                        ),
                      ),
                    ),
                  ),
                    onTap: () async {
                      FocusScope.of(context).unfocus();
            
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
            
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: ColorsWidgets.mainAppColor,
                                onPrimary: Colors.white,
                                onSurface: ColorsWidgets.darkGreen,
                              ),
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: child!,
                          );
                        },
                      );
            
                      if (pickedDate != null) {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                      }
                    }
                ),
                SizedBox(height: 30),
                Text(
                  TextsWidgets.searchScreenRadioReport,
                  style: FontsWidgets.poppins(
                    fontWeight: FontWeight.w500,
                    fontColor: ColorsWidgets.darkGreen,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 0,
                          groupValue: selectedValue,
                          activeColor: ColorsWidgets.mainAppColor,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        Text(
                          TextsWidgets.searchScreenRadioIncome,
                          style: FontsWidgets.poppins(
                            fontWeight: FontWeight.w400,
                            fontColor: ColorsWidgets.darkGreen,
                          ),
                        ),
                      ],
                    ),
            
                    SizedBox(width: 30),
            
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedValue,
                          activeColor: ColorsWidgets.mainAppColor,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        Text(
                          TextsWidgets.searchScreenRadioExpense,
                          style: FontsWidgets.poppins(
                            fontWeight: FontWeight.w400,
                            fontColor: ColorsWidgets.darkGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 54,),
                Center(
                  child: ButtonWidgets.appButton(
                    text: TextsWidgets.searchScreenTitle,
                    onTap: () {},
                    height: 36,
                    width: 169,
                    backgroundColor: ColorsWidgets.mainAppColor,
                    textColor: ColorsWidgets.darkGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24,),
                ListView.builder(
                  itemCount: searchTransactionsList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {

                    final item = searchTransactionsList[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SearchTransactionItem().searchTransactionItem(
                        icon: item["icon"],
                        title: item["title"],
                        timeDate: item["timeDate"],

                        amount: item["amount"],
                        isExpense: item["isExpense"], context: context,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomSize: 14,
      ),
    );
  }
}
