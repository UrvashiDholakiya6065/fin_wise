import 'package:fin_wise/AppRoute/app_route.dart';
import 'package:fin_wise/AppRoute/app_route_path.dart';
import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
import 'package:fin_wise/Bloc/LanguageBloc/language_bloc.dart';
import 'package:fin_wise/Bloc/LanguageBloc/language_state.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/Texts/language_controller.dart';
import 'package:fin_wise/Utilites/GlobalWidgets/ThemeHelper/time_greeting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_bloc.dart';
import '../../../../Bloc/AuthBloc/auth_event.dart';
import '../../../../Network/TranslateRepo/transalre_repo.dart';
import '../../../../Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
import '../../../../Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';
import '../HomeWidgets/balance_summery_Widget.dart';
import '../HomeWidgets/period_selector_widget.dart';
import '../HomeWidgets/savings_goals_widget.dart';
import '../HomeWidgets/transaction_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String translatedName = "";
  String lastName = "";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(FetchUserEvent());
  }

  Future<void> translateName(String name) async {
    if (name.isEmpty || name == lastName) return;

    lastName = name;

    final lang = context.read<LanguageBloc>().state.currentLang;

    if (lang == 'en') {
      setState(() {
        translatedName = name;
      });
      return;
    }

    final result = await TranslationService.translate(name, lang);

    setState(() {
      translatedName = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        "icon": ImagesWidget.wallet,

        "title": AppLocalizations.of(context)?.translate("Salary") ?? "Salary",

        "timeDate":
            AppLocalizations.of(context)?.translate("18:27 - April 30") ??
            "18:27 - April 30",

        "category":  AppLocalizations.of(context)?.translate("Monthly") ?? "Monthly",
        "amount": formatAmount(4000, context),
        "isExpense": false,
      },
      {
        "icon": ImagesWidget.groceriesIcon,

        "title":
            AppLocalizations.of(context)?.translate("Groceries") ?? "Groceries",

        "timeDate":
            AppLocalizations.of(context)?.translate("17:00 - April 24") ??
            "17:00 - April 24",

        "category":  AppLocalizations.of(context)?.translate("Pantry") ?? "Pantry",
        "amount": formatAmount(-100, context),
        "isExpense": true,
      },
      {
        "icon": ImagesWidget.rentIcon,

        "title": AppLocalizations.of(context)?.translate("Rent") ?? "Rent",

        "timeDate":
            AppLocalizations.of(context)?.translate("8:30 - April 15") ??
            "8:30 - April 15",

        "category":  AppLocalizations.of(context)?.translate("Rent") ?? "Rent",
        "amount": formatAmount(-67440, context),
        "isExpense": true,
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, langState) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final userName = state.userModel?.fullName ?? "User";

                translateName(userName);

                return CommonAppbar().commonAppBar(
                  title:
                      "${AppLocalizations.of(context)?.translate('hi')}, ${translatedName.isEmpty ? userName : translatedName}",

                  subtitle: TimeGreeting().getGreeting(),
                );
              },
            );
          },
        ),
      ),
      body: CommonAppUi(
        topWidget: BalanceSummeryWidget().balanceSummaryWidget(context),
        bottomWidget: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // final userName = state.userModel?.fullName;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 18,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        appRoute.push(AppRoutePath.quicklyAnalysisScreen.path);
                      },
                      child: SavingsGoalsWidget().savingsGoalsWidget(context),
                    ),
                    SizedBox(height: 24),
                    PeriodSelectorWidget().periodSelectorWidget(context),
                    SizedBox(height: 18),

                    ListView.builder(
                      itemCount: transactions.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = transactions[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: TransactionItemWidget().transactionItemWidget(
                            icon: item["icon"],
                            title: item["title"],
                            timeDate: item["timeDate"],
                            category: item["category"],
                            amount: item["amount"],
                            isExpense: item["isExpense"],
                            context: context,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomSize: 4,
      ),
    );
  }
}

// import 'package:fin_wise/AppRoute/app_route.dart';
// import 'package:fin_wise/AppRoute/app_route_path.dart';
// import 'package:fin_wise/Bloc/AuthBloc/auth_state.dart';
// import 'package:fin_wise/Bloc/LanguageBloc/language_bloc.dart';
// import 'package:fin_wise/Utilites/GlobalWidgets/CommonAppUi/common_app_ui.dart';
// import 'package:fin_wise/Utilites/GlobalWidgets/ThemeHelper/time_greeting.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../Bloc/AuthBloc/auth_bloc.dart';
// import '../../../../Bloc/AuthBloc/auth_event.dart';
// import '../../../../Network/TranslateRepo/transalre_repo.dart';
// import '../../../../Utilites/GlobalWidgets/CommonAppBar/common_appbar.dart';
// import '../../../../Utilites/GlobalWidgets/PngImages/images_widget.dart';
// import '../../../../Utilites/GlobalWidgets/Texts/language_controller.dart';
// import '../../../../Utilites/GlobalWidgets/ThemeHelper/indian_currency_format.dart';
// import '../HomeWidgets/balance_summery_Widget.dart';
// import '../HomeWidgets/period_selector_widget.dart';
// import '../HomeWidgets/savings_goals_widget.dart';
// import '../HomeWidgets/transaction_item_widget.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String translatedName = "";
//   String lastName = "";
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<AuthBloc>().add(FetchUserEvent());
//   }
//
//   // 🔥 TRANSLATE FUNCTION
//   Future<void> translateName(String name) async {
//     if (name.isEmpty || name == lastName) return;
//
//     lastName = name;
//
//     final lang = context.read<LanguageBloc>().state.currentLang;
//
//     if (lang == 'en') {
//       setState(() {
//         translatedName = name;
//       });
//       return;
//     }
//
//     final result = await TranslationService.translate(name, lang);
//
//     setState(() {
//       translatedName = result;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> transactions = [
//       {
//         "icon": ImagesWidget.wallet,
//         "title": "Salary",
//         "timeDate": "18:27 - April 30",
//         "category": "Monthly",
//         "amount": formatAmount(4000, context),
//         "isExpense": false
//       },
//       {
//         "icon": ImagesWidget.groceriesIcon,
//         "title": "Groceries",
//         "timeDate": "17:00 - April 24",
//         "category": "Pantry",
//         "amount": formatAmount(-100, context),
//         "isExpense": true
//       },
//       {
//         "icon": ImagesWidget.rentIcon,
//         "title": "Rent",
//         "timeDate": "8:30 - April 15",
//         "category": "Rent",
//         "amount": formatAmount(-67440, context),
//         "isExpense": true
//       },
//     ];
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(70),
//
//         child: BlocBuilder<AuthBloc, AuthState>(
//           builder: (context, state) {
//             final userName = state.userModel?.fullName ?? "User";
//
//             translateName(userName);
//
//             return CommonAppbar().commonAppBar(
//
//               title: "${ AppLocalizations.of(context)?.translate('hi')}, ${translatedName.isEmpty ? userName : translatedName}",
//               subtitle: TimeGreeting().getGreeting(),
//             );
//           },
//         ),
//       ),
//
//       body: CommonAppUi(
//         topWidget: BalanceSummeryWidget().balanceSummaryWidget(context),
//
//         bottomWidget: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     appRoute.push(AppRoutePath.quicklyAnalysisScreen.path);
//                   },
//                   child: SavingsGoalsWidget().savingsGoalsWidget(context),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 PeriodSelectorWidget().periodSelectorWidget(context),
//
//                 const SizedBox(height: 18),
//
//                 ListView.builder(
//                   itemCount: transactions.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     final item = transactions[index];
//
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 8),
//                       child: TransactionItemWidget().transactionItemWidget(
//                         icon: item["icon"],
//                         title: item["title"],
//                         timeDate: item["timeDate"],
//                         category: item["category"],
//                         amount: item["amount"],
//                         isExpense: item["isExpense"],
//                         context: context,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         bottomSize: 4,
//       ),
//     );
//   }
// }
